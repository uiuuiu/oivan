#!/usr/bin/env puma
# frozen_string_literal: true

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('PUMA_THREADS') { 5 }.to_i
threads threads_count, threads_count

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch('WORKERS') { 1 }.to_i

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
#
# port ENV.fetch('PORT') { 3000 }
# app_dir = File.expand_path("../..", __FILE__)
# shared_dir = "#{app_dir}/shared"
shared_dir = "/srv/shared/prd"

# Set up socket location
bind "unix://#{shared_dir}/tmp/sockets/puma.sock"
# Logging
stdout_redirect "#{shared_dir}/tmp/log/puma.stdout.log", "#{shared_dir}/tmp/log/puma.stderr.log", true
# Set master PID and state locations
pidfile "#{shared_dir}/tmp/pids/puma.pid"
state_path "#{shared_dir}/tmp/pids/puma.state"
activate_control_app
