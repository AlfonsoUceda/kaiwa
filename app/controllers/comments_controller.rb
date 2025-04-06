class CommentsController < ApplicationController
  before_action :set_project

  # GET /projects/:project_id/comments/new
  def new
  end

  # POST /projects/:project_id/comments
  def create
    @comment = @project.comments.build(comment_params)

    if @comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(
              "comments",
              partial: "comments/comment",
              locals: { comment: @comment }
            ),
            turbo_stream.replace(
              "new_comment",
              partial: "projects/new_comment"
            )
          ]
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              "new_comment",
              partial: "comments/form",
              locals: { comment: @comment }
            )
          ]
        end
      end
    end
  end

  private

    def comment_params
      params.expect(comment: [ :body ])
    end

    def set_project
      @project = Project.find(params.expect(:project_id))
    end
end
