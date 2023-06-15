# CCS CONCLAVE DOCUMENT UPLOAD SERVICE
This is the Upload service which is part of the Conclave Document Upload Services

## Nomenclature

- **Client**: used for basic token authentication. For each application that can post to this service, a Client object needs to be created
- **Document**: used to store the state of the file and to be used to retrieve the file once threat scanning succeeds
- **UncheckedDocument**: used to store the file initially, until the threat scanning is run. This is also the object that gets passed through to the Checker service to run threat scanning

## Technical documentation

This is a Ruby on Rails application that takes a file or a file path, saves it in the database and on S3, and calls the Checker service to run threat scanning. It's only presented as an internal API and doesn't face public users.

### Setup instructions
#### For OSX/macOS version 10.9 or higher

##### 1. Install command line tools on terminal

`xcode-select --install`

##### 2. Install Hombrew

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

##### 2. Install rbenv

`brew update`
`brew install rbenv`
`echo 'eval "$(rbenv init -)"' >> ~/.bash_profile`
`source ~/.bash_profile`

##### 3. Build ruby 3.0.3 with rbenv

`rbenv install 3.0.3`
`rbenv global 3.0.3`

##### 4. Install rails 6.1.7
`gem install rails -v 6.1.7`

#### 5. Download and install Postgresql 10
Go to https://www.postgresql.org/ and download the installer

#### 6. Create and migrate the database
`rake db:create && rake db:migrate`

### Running the application

To run the rails server, from your console do:
`rails s`

You can now use the service by sending a POST request to: `localhost:3000/document-upload`

### Running the test suite

To run the specs, from your console do:
`rspec spec`
