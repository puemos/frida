defmodule Frida.FeedbacksTest do
  use Frida.DataCase

  alias Frida.Feedbacks

  describe "feedbacks" do
    alias Frida.Feedbacks.Feedback

    @valid_attrs %{created_at: "2010-04-17T14:00:00Z", details: "some details", title: "some title"}
    @update_attrs %{created_at: "2011-05-18T15:01:01Z", details: "some updated details", title: "some updated title"}
    @invalid_attrs %{created_at: nil, details: nil, title: nil}

    def feedback_fixture(attrs \\ %{}) do
      {:ok, feedback} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feedbacks.create_feedback()

      feedback
    end

    test "list_feedbacks/0 returns all feedbacks" do
      feedback = feedback_fixture()
      assert Feedbacks.list_feedbacks() == [feedback]
    end

    test "get_feedback!/1 returns the feedback with given id" do
      feedback = feedback_fixture()
      assert Feedbacks.get_feedback!(feedback.id) == feedback
    end

    test "create_feedback/1 with valid data creates a feedback" do
      assert {:ok, %Feedback{} = feedback} = Feedbacks.create_feedback(@valid_attrs)
      assert feedback.created_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert feedback.details == "some details"
      assert feedback.title == "some title"
    end

    test "create_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feedbacks.create_feedback(@invalid_attrs)
    end

    test "update_feedback/2 with valid data updates the feedback" do
      feedback = feedback_fixture()
      assert {:ok, %Feedback{} = feedback} = Feedbacks.update_feedback(feedback, @update_attrs)
      assert feedback.created_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert feedback.details == "some updated details"
      assert feedback.title == "some updated title"
    end

    test "update_feedback/2 with invalid data returns error changeset" do
      feedback = feedback_fixture()
      assert {:error, %Ecto.Changeset{}} = Feedbacks.update_feedback(feedback, @invalid_attrs)
      assert feedback == Feedbacks.get_feedback!(feedback.id)
    end

    test "delete_feedback/1 deletes the feedback" do
      feedback = feedback_fixture()
      assert {:ok, %Feedback{}} = Feedbacks.delete_feedback(feedback)
      assert_raise Ecto.NoResultsError, fn -> Feedbacks.get_feedback!(feedback.id) end
    end

    test "change_feedback/1 returns a feedback changeset" do
      feedback = feedback_fixture()
      assert %Ecto.Changeset{} = Feedbacks.change_feedback(feedback)
    end
  end
end
