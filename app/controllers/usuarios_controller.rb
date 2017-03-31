class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :update, :destroy]
  #ActionController::Parameters.action_on_unpermitted_parameters = :raise

  # GET /usuarios
  def index
    @usuarios = Usuario.all
    render json: {usuarios: @usuarios , total: @usuarios.size}
  end

  # POST /usuarios
  # aca tengo que crear la response de no se pudo crear etc.
  def create
    if (params.has_key?(:id))
      @id = params[:id]
      render json: {error: "No se puede crear usuario con id"  },status: 400
    else
      begin
        @usuario = Usuario.create!(usuario_params)
        json_response(@usuario, :created)  
      rescue ActiveRecord::RecordInvalid
        render json:{error: "La creación ha fallado"}, status: 500
      end
      
    end
  end

  # GET /usuarios/:id
  def show
    json_response(@usuario)
  end

  # PUT /usuarios/:id
  def update
      if (params.has_key?(:id))
        @user = params[:usuario]
        if @user.has_key?("id")
          render json: {error: "id no es modificable"}, status:400
        else
          begin
            @usuario.update(usuario_params)
            render json: @usuario , status: 200
          rescue ActiveRecord::RecordInvalid
            render json:{error: "La modificación ha fallado"}, status: 500
          end
        end
      end
      
  end

  # DELETE /usuarios/:id
  def destroy
    @usuario.destroy
    head format: JSON ,status:204
  end

  private

  def usuario_params
    # whitelist params
    params.permit(:usuario, :nombre, :twitter , :apellido)
  end

  def set_usuario
    @usuario = Usuario.find(params[:id])
  end
end