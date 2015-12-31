# Kaustav's Emacs configurations

These are my new set of configurations, initially inspired by the choices made in Emacs Prelude. It is focused on getting rich, but lightweight, editing experience in JavaScript, Golang and Rust.

## Install

1. **Clone the repository**

    ```bash
    $ git clone git@github.com:kaustavdm/dotemacs --recursive
    ```

2. **Set-up symlink**

    ```bash
    $ ln -s <path-to>/dotemacs ~/.emacs.d
    ```

3. **Set-up dependencies available on npm**

    ```bash
    $ sudo npm install -g aspell jslint tern
    ```

4. **Set-up Go dependencies**

    - Install Golang
    - Set `GOPATH` environment variable
    - Install Gocode: `$ go get -u github.com/nsf/gocode`.
    - Make sure `gocode` executible is on `PATH`.

5. **Set-up Rust dependencies**

    - [Install Rust](https://www.rust-lang.org/install.html)
    - Download Rust sources and set `RUST_SRC_PATH` environment variable to the `./src` directory in the Rust source.
    - Install Racer: `$ cargo install --git 'https://github.com/phildawes/racer.git'`
    - Make sure the `racer` executible is on `PATH`.

6. **Copy**: `./custom/env-custom-sample.el` to `./custom/env-custom.el`, and adjust values in `env-custom.el`.

7. **Run `emacs`**. It will install missing packages. Make sure you are connected to the internet at this point.
