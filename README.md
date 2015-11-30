# Kaustav's Emacs configurations

These are my new set of configurations, partly inspired by the choices made in Emacs Prelude, but mostly to suite web and JavaScript development.

## Install

1. Clone the repository

    ```bash
    $ git clone git@github.com:kaustavdm/dotemacs
    ```

2. Set-up symlink and install dependencies.

    ```bash
    $ ln -s <path-to>/dotemacs ~/.emacs.d
    $ sudo npm install -g jslint
    ```

3. Copy `./custom/env-custom-sample.el` to `./custom/env-custom.el`, and adjust values in `env-custom.el`.

4. Run `emacs`. It will install missing packages. Make sure you are connected to the internet at this point.
