require 'test_helper'

class TbEventosControllerTest < ActionController::TestCase
  setup do
    @tb_evento = tb_eventos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tb_eventos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tb_evento" do
    assert_difference('TbEvento.count') do
      post :create, tb_evento: { data: @tb_evento.data, descricao: @tb_evento.descricao, limite_participantes: @tb_evento.limite_participantes, local: @tb_evento.local, nome: @tb_evento.nome }
    end

    assert_redirected_to tb_evento_path(assigns(:tb_evento))
  end

  test "should show tb_evento" do
    get :show, id: @tb_evento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tb_evento
    assert_response :success
  end

  test "should update tb_evento" do
    patch :update, id: @tb_evento, tb_evento: { data: @tb_evento.data, descricao: @tb_evento.descricao, limite_participantes: @tb_evento.limite_participantes, local: @tb_evento.local, nome: @tb_evento.nome }
    assert_redirected_to tb_evento_path(assigns(:tb_evento))
  end

  test "should destroy tb_evento" do
    assert_difference('TbEvento.count', -1) do
      delete :destroy, id: @tb_evento
    end

    assert_redirected_to tb_eventos_path
  end
end
