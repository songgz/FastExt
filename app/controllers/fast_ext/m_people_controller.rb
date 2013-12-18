# encoding: utf-8
require_dependency "fast_ext/application_controller"

module FastExt
  class MPeopleController < ApplicationController
    before_action :set_m_person, only: [:show, :edit, :update, :destroy]
    respond_to :html, :xml, :json

    def index
      #limit = params[:limit].to_i
      #start = params[:start].to_i
      #search = params[:search]
      #if search.blank?
      #  @m_people = MPerson.all
      #  @records = MPerson.limit(limit).offset(start)
      #else
      #  @m_people = MPerson.where("title LIKE :input", {:input => "%#{search}%"})
      #  @records = @m_people.limit(limit).offset(start)
      #end
      #data ={
      #    :totalCount => @m_people.length,
      #    :rows => @records
      #}
      @m_people = MPerson.all
      data = paginate(@m_people)
      respond_with(data.to_json)
    end

    def show
      #@m_person = MPerson.find(params[:id])
      respond_with(@m_person)
    end

    def edit
      #@m_person = MPerson.find(params[:id])
      respond_with(@m_person)
    end

    def new
      @m_person = MPerson.new
      respond_with(@m_person)
    end

    def create
      @m_person = MPerson.new(m_person_params)
      respond_with(@m_person) do |format|
        if @m_person.save
          format.json { render :json => {:success => true, :msg => 'ok'} }
        else
          format.json { render :json => {:success => false, :msg => 'failure'} }
        end
      end

    end

    def update
      #@m_person = MPerson.find(params[:id])

      respond_with(@m_person) do |format|
        if @m_person.update_attributes(m_person_params)
          format.json { render :json => {:success => true, :msg => 'ok'} }
        else
          format.json { render :json => {:success => false, :msg => 'false'} }
        end
      end
    end

    def destroy
      #@m_person = MPerson.find(params[:id])
      @m_person.destroy
      respond_with(@m_person)
    end

    def login
      @m_person = MPerson.where(:name => params[:UserName]).first_or_initialize
      respond_with(@m_person) do |format|
        if @m_person
          format.json { render :json => {:success => true, :msg => 'ok'} }
        else
          format.json { render :json => {:success => false, :msg => 'false'} }
        end
      end

    end

    def logout

    end

    private
    def set_m_person
      @m_person = MPerson.find(params[:id])
    end

    def m_person_params
      params[:m_person].permit!
    end


  end
end