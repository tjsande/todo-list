defmodule TodoWeb.TaskController do
    use TodoWeb, :controller

    alias Todo.Task
    alias Todo.Repo

    def index(conn, _params) do
        tasks = Repo.all(Task)
        render conn, "index.html", tasks: tasks
    end

    def new(conn, _params) do
        changeset = Task.changeset(%Task{}, %{})
        render conn, "new.html", changeset: changeset
    end


    def create(conn, %{"task" => task}) do
        changeset = Task.changeset(%Task{}, task)

        case Repo.insert(changeset) do
            {:ok, _task} -> 
                conn
                |> put_flash(:info, "Task Created")
                |> redirect(to: Routes.task_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => task_id}) do
        task = Repo.get(Task, task_id)
        changeset = Task.changeset(task)

        render conn, "edit.html", changeset: changeset, task: task
    end

    def update(conn, %{"id" => task_id, "task" => task}) do
        old_task = Repo.get(Task, task_id)
        changeset = Task.changeset(old_task, task)

        case Repo.update(changeset) do
            {:ok, _task} ->
                conn
                |> put_flash(:info, "Task Updated")
                |> redirect(to: Routes.task_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, task: old_task
        end
    end

    def delete(conn, %{"id" => task_id}) do
        Repo.get!(Task, task_id) |> Repo.delete!

        conn
        |> put_flash(:info, "Task Deleted")
        |> redirect(to: Routes.task_path(conn, :index))
    end
end
