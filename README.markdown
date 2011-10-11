Setting up a dashboard using dboard
---

0) Get a heroku account at http://www.heroku.com/ and add a credit card to authorize the account. We need memcached, which is free, but requires an authorized account.

1) Get a basic repo:

    git clone https://github.com/joakimk/dboard_example dashboard
    cd dashboard
    rm -rf .git
    git init
    git add .
    git commit -m "Initial commit"

2) Create a heroku app:

    bundle
    heroku create my-dashboard -s bamboo-mri-1.9.2 

2) Go to heroku and add the free 5mb memcached option (addons -> memcached: learn more -> add).

![Addons](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step1.png)
![Memcache](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step2.png)
![Add](https://github.com/joakimk/dboard_example/raw/master/docs/add_memcache_step3.png)

3) Deploy

    git push heroku master

    # Ensure it loads
    open "http://my-dashboard.heroku.com"

3) Report some data:

    ruby cpu_usage_reporter.rb

4) Check your dashboard, it should now print your local CPU usage.
