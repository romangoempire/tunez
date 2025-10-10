# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tunez.Repo.insert!(%Tunez.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

password = "password"

[
  {"admin@email", :admin},
  {"editor@email", :editor},
  {"user@email", :user}
]
|> Enum.each(fn {email, role} ->
  Tunez.Accounts.User
  |> Ash.Changeset.for_create(:register_with_password, %{
    email: email,
    password: password,
    password_confirmation: password
  })
  |> Ash.create!(authorize?: false)
  |> Tunez.Accounts.set_user_role!(role, authorize?: false)
end)
