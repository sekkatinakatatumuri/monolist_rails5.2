class OwnershipsController < ApplicationController
  def create
    # find_or_initialize_by は find_by して見つかればテーブルに保存されていたインスタンスを返し、
    # 見つからなければ new して新規作成する便利メソッド
    @item = Item.find_or_initialize_by(code: params[:item_code])

    # 取得したインスタンスが保存済みか確認(保存されていない場合true)
    unless @item.persisted?
      # itemCode で楽天市場を検索する(要素が1つの配列が返る)
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      # 配列の最初を取得(ApplicationControllerのreadメソッドで成型)
      @item = Item.new(read(results.first))
      # @item が保存されていないと Want できずにスルーされるため保存
      @item.save
    end

    # Want 関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品を Want しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])

    if params[:type] == 'Want'
      current_user.unwant(@item) 
      flash[:success] = '商品の Want を解除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end
