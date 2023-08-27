# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "popper", to: 'popper.js', preload: true
pin_all_from "app/javascript/controllers", under: "controllers", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.7/src/index.js"

pin_all_from 'app/javascript/slideshow', under: 'slideshow'
