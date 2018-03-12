#!/bin/bash

cd /var/www/

sudo rm -f index.html
sudo rm -rf report-*

cd /var/www/code/

touch ../index.html

cat <<EOT >> ../index.html
<!doctype html>
<html lang="en">
  <head>
      <!-- Required meta tags -->
          <meta charset="utf-8">
              <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

                  <!-- Bootstrap CSS -->
                      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

                          <title>PHPMetrics</title>
                            </head>
                            <nav class="navbar navbar-light" style="background-color: #e3f2fd;>
                              <span class="navbar-brand mb-0 h1">PHPMetrics</span>
                              </nav>
                              <body>
                              <div class="form-group">
EOT

for V in */
do
    php ../vendor/bin/phpmetrics --report-html=../report-$V $V
    echo '<a href="report-'$V'/" class="btn btn-info form-control">'$V'</a><br><br>' >> ../index.html
done

cat <<EOT >> ../index.html
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
          </body>
          </html>
EOT

cd ..

php -S 0.0.0.0:8080
