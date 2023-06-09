require 'json'


class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  post '/users' do
    content_type :json
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id # Store the user ID in the session
      status 201
      { user_id: user.id }.to_json
    else
      status 400
      { error: 'Failed to create user' }.to_json
    end
  end

  post '/login' do
    content_type :json
    user = User.find_by(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id # Store the user ID in the session
      status 200
      { user_id: user.id, user: user }.to_json
    else
      status 401
      { error: 'Invalid credentials' }.to_json
    end
  end


  get '/appointments' do
    content_type :json
    appointments = Appointment.all
    appointments.to_json
  end

  post '/appointments' do
    content_type :json
    appointment = Appointment.new(hospital: params[:hospital], date: params[:date], time: params[:time], reason: params[:reason])
    if appointment.save
      status 201
      appointment.to_json
    else
      status 400
      { error: 'Failed to create appointment' }.to_json
    end
  end

  get '/appointments/:id' do
    content_type :json
    appointment = Appointment.find_by(id: params[:id])
    if appointment
      appointment.to_json
    else
      status 404
      { error: 'Appointment not found' }.to_json
    end
  end

  put '/appointments/:id' do
    content_type :json
    appointment = Appointment.find_by(id: params[:id])
    if appointment
      if appointment.update(hospital: params[:hospital], date: params[:date], time: params[:time], reason: params[:reason])
        appointment.to_json
      else
        status 400
        { error: 'Failed to update appointment' }.to_json
      end
    else
      status 404
      { error: 'Appointment not found' }.to_json
    end
  end


  delete '/appointments/:id' do
    content_type :json
    appointment = Appointment.find_by(id: params[:id])
    if appointment
      appointment.destroy
      { message: 'Appointment deleted' }.to_json
    else
      status 404
      { error: 'Appointment not found' }.to_json
    end
  end
end
