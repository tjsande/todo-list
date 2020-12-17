defmodule Todo.Task do
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
  end

  def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:description])
      |> validate_required([:description])
  end
end
