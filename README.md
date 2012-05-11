# Per-user RVM in Puppet

This is a quick-hack module to blindly execute scripts straight from the [RVM
folks](http://rvm.io).

Usage:

    node default {
      rvm::install {
        # Install per-user RVM for rtyler
        'rtyler' : ;
      }
    }

THe `rvm::install` defined type will automatically require `User['rtyler']` in
the above example
