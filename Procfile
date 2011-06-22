web:     bundle exec rails server thin -p $PORT
worker:  bundle exec QUEUE=* rake resque:work
clock:   bundle exec rake resque:scheduler
