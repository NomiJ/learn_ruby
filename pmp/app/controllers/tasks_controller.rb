class TasksController < ApplicationController

    before_action :find_project
    before_action :find_task, only: [:destroy, :complete]
    def create
        @task = @project.tasks.create(task_params)
        if @task.save!
            redirect_to @project
        else
            render 'new'
        end

    end

    def complete
        @task.update_attribute(:completed_at, Time.now)
        redirect_to @project, notice: 'Task Completed'
    end
    
    def destroy
        if @task.destroy
            flash[:success] = 'Task deleted successfully'
        else
            flash[:error] = 'Task cannot be deleted successfully'
        end
        redirect_to @project
    end
    
    

private
    def find_project
        @project = Project.find(params[:project_id])
    end
    def find_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:content)
    end
    
end
