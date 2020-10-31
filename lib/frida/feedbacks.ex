defmodule Frida.Feedbacks do
  @moduledoc """
  The Feedbacks context.
  """

  import Ecto.Query, warn: false
  alias Frida.Repo

  alias Frida.Feedbacks.Feedback

  def list_feedbacks do
    Repo.all(Feedback)
  end

  def get_feedback!(id), do: Repo.get!(Feedback, id)

  def create_feedback(attrs \\ %{}, user) do
    %Feedback{}
    |> Feedback.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def update_feedback(%Feedback{} = feedback, attrs) do
    feedback
    |> Feedback.changeset(attrs)
    |> Repo.update()
  end

  def delete_feedback(%Feedback{} = feedback) do
    Repo.delete(feedback)
  end

  def change_feedback(%Feedback{} = feedback, attrs \\ %{}) do
    Feedback.changeset(feedback, attrs)
  end
end
