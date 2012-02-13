There is an example deployed at: https://dboard-example.heroku.com

Setting up a dashboard using dboard
---


Get a heroku account at http://www.heroku.com/ and add a credit card to authorize the account. We need memcached, which is free, but requires an authorized account.

NOTE: This is work in progress. For example, there is nothing here about security yet. I've not tested the entire instruction from scratch yet.




Get a basic repo:

    git clone https://github.com/joakimk/dboard_example dashboard
    cd dashboard
    rm -rf .git
    git init
    git add .
    git commit -m "Initial commit"

Create a heroku app:

    bundle
    heroku create some-dashboard -s bamboo-mri-1.9.2 

Go to heroku and add the free 5mb memcached option (addons -> memcached: learn more -> add).

![Addons](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step1.png)

![Memcache](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step2.png)

![Add](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step3.png)

Deploy

    git push heroku master

Ensure it loads (your url will be something like http://_some-dashboard_.heroku.com).

Report some data:

    ruby cpu_usage_reporter.rb

Check your dashboard, it should now print your local CPU usage.

This example does not use [twitter bootstrap](http://twitter.github.com/bootstrap/scaffolding.html), but it's a simple way to get some structure. We use a modified version of twitter bootstrap 2 for our dashboard. [32 column bootstrap css for 1920 x 1080 displays](https://raw.github.com/barsoom/bootstrap/1080_32_columns/docs/assets/css/bootstrap.css).
