defmodule Frida.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Frida.Repo

  alias Frida.Posts.{Post, Like, Comment}

  def list_posts do
    Repo.all(
      from f in Post,
        preload: [:likes, :comments, :status]
    )
  end

  def get_post!(id) do
    Repo.get!(Post, id)
    |> Repo.preload([:likes, [comments: :user], :user, :status])
  end

  def create_post(attrs \\ %{}, user) do
    %Post{}
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def add_like_post(post, user) do
    %Like{}
    |> Like.changeset(%{post_id: post.id, user_id: user.id})
    |> Repo.insert()
  end

  def add_status_post(post, status) do
    post
    |> Post.changeset(%{status_id: status.id})
    |> Repo.update()
  end

  def create_comment_post(comment) do
    %Comment{}
    |> Comment.changeset(comment)
    |> Repo.insert()
  end

  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias Frida.Posts.Status

  @doc """
  Returns the list of status.

  ## Examples

      iex> list_status()
      [%Status{}, ...]

  """
  def list_status do
    Repo.all(
      from f in Status,
        preload: [:posts]
    )
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{data: %Status{}}

  """
  def change_status(%Status{} = status, attrs \\ %{}) do
    Status.changeset(status, attrs)
  end
end
