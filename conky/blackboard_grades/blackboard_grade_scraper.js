var casper = require('casper').create();

function login(username, password, username_elem, password_elem, login_button){
        this.fill(username_elem, username)
        this.fill(password_elem, password)
        this.mouse.click(login_button)
}

casper.start('https://learn.uark.edu')
casper.evaluate(login('noahholt', 'asdf', 'input#user-id', 'input#password-id', '#entry-login'))
