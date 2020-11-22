alias Frida.Repo
alias Frida.Posts.Status

Repo.insert!(%Status{
  name: "Idea",
  color: "gray",
  order: 0
})

Repo.insert!(%Status{
  name: "WIP",
  color: "blue",
  order: 1
})

Repo.insert!(%Status{
  name: "Done",
  color: "green",
  order: 2
})
