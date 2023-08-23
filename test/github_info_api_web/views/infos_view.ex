defmodule GithubInfoApiWeb.UsersViewTest do
  use GithubInfoApiWeb.ConnCase, async: true

  import Phoenix.View
  import GithubInfoApi.Factory

  alias GithubInfoApiWeb.UserView

  test "renders create.json" do
    user = build(:user)
    token = "xpto1234"

    response = render(UserView, "create.json", token: token, user: user)

    assert %{
             message: "User created",
             token: "xpto1234",
             user: %Rockelivery.User{
               address: "Rua dos testes, 1234",
               age: 27,
               cep: "01001000",
               cpf: "12345678900",
               email: "teste@teste.com",
               id: "5b1addd2-0493-4cfd-9d61-cf662594e685",
               inserted_at: nil,
               name: "Teste 01",
               password: nil,
               password_hash:
                 "$pbkdf2-sha512$160000$.hT6ZwQcwH1.6acsV.Q4vQ$hZMVoNRIVkZNSJOqhV6NnB65V4Glv4J/p8iefVd1OdsYJ/e81q2tH.bvxZpxICbnBypBNo0Rvd8vZM2iVK5UzQ",
               updated_at: nil
             }
           } = response
  end
end
