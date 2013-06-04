#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  MAX_LIVING_SECOND = 10

  @@online_users = {}
  @@anonymous_users = {}

  before_filter :touch, :sweep_users
  helper_method :touch

  # 覆写devise登录
  def sign_in(*args)
    super(*args)

    @@online_users[current_user.email] = Time.now
    @@anonymous_users.delete request.session_options[:id]
  end

  def sign_out(*args)
    @@online_users.delete current_user.email

    super(*args)

    @@anonymous_users[request.session_options[:id]] = Time.now
  end

  def touch
    if current_user
      @@online_users[current_user.email] = Time.now
    else
      @@anonymous_users[request.session_options[:id]] = Time.now
    end
    puts 'Touch'
    puts @@online_users
    puts @@anonymous_users
  end

  def sweep_users
    t = Time.now
    # 时间要比心跳的间隔长，给程序处理的时间和网络问题
    @@online_users.reject! do |k, v|
      t - v > MAX_LIVING_SECOND
    end
    @@anonymous_users.reject! do |k, v|
      t - v > MAX_LIVING_SECOND
    end
    puts 'Sweep'
    puts @@online_users
    puts @@anonymous_users
  end
end
