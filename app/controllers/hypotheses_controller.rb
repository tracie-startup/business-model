class HypothesesController < ApplicationController
  before_action :set_hypothesis, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /hypotheses
  # GET /hypotheses.json
  def index
    @hypotheses = Hypothesis.all
    @grouped_hypotheses = Hypothesis.all.group_by{ |hypothesis| hypothesis.business_model_part}
  end

  # GET /hypotheses/1
  # GET /hypotheses/1.json
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @version = params[:version]
    unless @version.blank?
      @hypothesis = @hypothesis.version_at(@version)
    end
  end

  # GET /hypotheses/new
  def new
    @hypothesis = Hypothesis.new
    @hypothesis.state = Hypothesis::STATE[:hypothetical]
    if params[:model_part]
      @hypothesis.business_model_part = Hypothesis::MODEL_PARTS[params[:model_part].to_sym] #Hypothesis::MODEL_PARTS[params[:model_part]]
    end
  end

  # GET /hypotheses/1/edit
  def edit
  end

  # POST /hypotheses
  # POST /hypotheses.json
  def create
    @hypothesis = Hypothesis.new(hypothesis_params)
    @hypothesis.created_by = current_user.id

    respond_to do |format|
      if @hypothesis.save
        format.html { redirect_to hypotheses_path, notice: 'Hypothesis was successfully created.' }
        format.json { render :show, status: :created, location: @hypothesis }
      else
        format.html { render :new }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hypotheses/1
  # PATCH/PUT /hypotheses/1.json
  def update
    respond_to do |format|
      if @hypothesis.update(hypothesis_params)
        format.html { redirect_to hypotheses_path, notice: 'Hypothesis was successfully updated.' }
        format.json { render :show, status: :ok, location: @hypothesis }
      else
        format.html { render :edit }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hypotheses/1
  # DELETE /hypotheses/1.json
  def destroy
    @hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'Hypothesis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hypothesis
      @hypothesis = Hypothesis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hypothesis_params
      params.require(:hypothesis).permit(:short_name, :state, :business_model_part, :hypotheses, :experiment, :pass_fail_criterion, :model_part)
    end
end
