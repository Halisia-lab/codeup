class User {
    int id;
    String email;
    String password;
    String firstname;
    String lastname;

    User(this.id, this.email, this.password, this.firstname, this.lastname);

    static List<User> getUsers() {
        List<User> users = [];
        users.add(new User(1, "hh@gmail.com", "psw", "halisia", "halifa"));

        return users;
    }
}
