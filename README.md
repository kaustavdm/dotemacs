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

    a. **If you are on Fedora, additionally install:**

    ```bash
    $ sudo dnf install aspell-en
    ```

    b. **If you are on OSX, additionally install:**

    ```bash
    $ brew install aspell --with-lang-en
    ```

4. **Set-up Go dependencies**

    - Install Golang
    - Set `GOPATH` environment variable
    - Install Gocode: `$ go get -u github.com/nsf/gocode`.
    - Install Golint: `$ go get -u github.com/golang/lint`.
    - Install Gorename: `$ go get golang.org/x/tools/cmd/gorename`.
    - Make sure `gocode`, `godef`, `golint` and `gorename` executibles are on `PATH`.

5. **Set-up Rust dependencies**

    - [Install Rust](https://www.rust-lang.org/install.html)
    - Download Rust sources and set `RUST_SRC_PATH` environment variable to the `./src` directory in the Rust source.
    - Install Racer: `$ cargo install racer`
    - Install Rustfmt: `$ cargo install rustfmt`
    - Make sure the `racer` and `rustfmt` executibles are on `PATH`.

6. **Set-up Haskell dependencies**

    - Install GHC, GHCi or better, install the Haskell Platform.

7. **Install Adobe Source Code Pro font**

    - Download and install the font from [Source Code Pro releases](https://github.com/adobe-fonts/source-code-pro/releases/latest).

8. **Copy**: `./custom/env-custom-sample.el` to `./custom/env-custom.el`, and adjust values in `env-custom.el`.

9. **Run `emacs`**. It will install missing packages. Make sure you are connected to the internet at this point.
