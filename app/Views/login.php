<!DOCTYPE html>
<html>
<head>
    <title>Login - Quizly</title>
</head>
<body>
    <h2>Login</h2>
    <?php if (session()->getFlashdata('error')): ?>
        <p style="color:red"><?= session()->getFlashdata('error') ?></p>
    <?php endif; ?>
    <form method="post" action="/login/auth">
        <label>Username</label><br>
        <input type="text" name="username"><br><br>

        <label>Password</label><br>
        <input type="password" name="password"><br><br>

        <button type="submit">Login</button>
    </form>
</body>
</html>
