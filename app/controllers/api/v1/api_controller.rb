class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :record_missing

  private

  def not_found
    head 404
  end

  def record_invalid(exception)
    render json: exception.record.errors.full_messages, status: :unprocessable_entity
  end
  def record_missing(exception)
    render json: 'Parâmetros inválidos', status: 406
  end
end