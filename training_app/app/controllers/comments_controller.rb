class CommentsController < ApplicationController
  def create
    @task = accessible_tasks.find(params[:task_id])
    @comment = @task.comments.build(params.require(:comment).permit(:body))
    if @comment.save
      redirect_to @task, notice: "Comment added."
    else
      render "tasks/show", status: :unprocessable_entity
    end
  end

  def destroy
    task = accessible_tasks.find(params[:task_id])
    task.comments.find(params[:id]).destroy!
    redirect_to task, notice: "Comment deleted.", status: :see_other
  end
end
