defmodule Todo.Repo.Migrations.AddTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
    end
  end
end
