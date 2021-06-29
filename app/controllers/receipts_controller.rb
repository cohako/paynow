class ReceiptsController < ApplicationController
before_action :set_receipt, only: %i[search_receipt]

  def show
    @receipt = Receipt.find_by(receipt_token: params[:receipt_token])
  end

  def search_receipt
    return redirect_to root_path, alert: "Recibo não encontrado, favor verificar código utilizado" if @receipt.nil?
    redirect_to receipt_path(@receipt.receipt_token)
  end

  private

  def receipt_params
    params.require(:receipt).permit(:receipt_token)
  end

  def set_receipt
    @receipt = Receipt.find_by(receipt_token: params[:receipt][:receipt_token])
  end
end