<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="B2CAdmin.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login </title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="AdminModule/plugins/fontawesome-free/css/all.min.css"/>
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="AdminModule/plugins/icheck-bootstrap/icheck-bootstrap.min.css"/>
    <!-- Theme style -->
    <link rel="stylesheet" href="AdminModule/dist/css/adminlte.min.css"/>
    <link rel="stylesheet" href="AdminModule/dist/css/adminlte.css" />

    <script src="sweet_alert/sweetalert-dev.js"></script>
    <link href="sweet_alert/sweetalert.css" rel="stylesheet" />
    <script src="sweet_alert/sweetalert.min.js"></script>
</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
        <div class="login-box">
            <!-- /.login-logo -->
            <div class="card card-outline card-primary">
                <div class="card-header text-center">
                    <a href="Default.aspx" class="h1"><b>Admin</b>WTS</a>
                </div>
                <div class="card-body">
                    <p class="login-box-msg">Sign in to start your session</p>

                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" ID="txtUserId" placeholder="Mobile No" class="form-control"></asp:TextBox>
                            <%--<input type="email" class="form-control" placeholder="Email">--%>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" ID="txtPassword" placeholder="Password" class="form-control" TextMode="Password"></asp:TextBox>
                            <%--<input type="password" class="form-control" placeholder="Password">--%>
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="remember">
                                    <label for="remember">
                                        Remember Me
                                    </label>
                                </div>
                            </div>
                            <!-- /.col -->
                            <div class="col-4">
                                <asp:Button runat="server" ID="btnSignIn" Text="Sign In" CssClass="btn btn-primary btn-block" OnClick="btnSignIn_Click"/>
                            </div>
                            <!-- /.col -->
                        </div>

                    <div class="social-auth-links text-center mt-2 mb-3">
                        <a href="#" class="btn btn-block btn-primary">
                            <i class="fab fa-facebook mr-2"></i>Sign in using Facebook
                        </a>
                        <a href="#" class="btn btn-block btn-danger">
                            <i class="fab fa-google-plus mr-2"></i>Sign in using Google+
                        </a>
                    </div>
                    <!-- /.social-auth-links -->

                    <p class="mb-1">
                        <a href="Forget Password.aspx" >I forgot my password</a>
                    </p>
                    <p class="mb-0">
                        <a href="Registration.aspx" class="text-center">Register a new membership</a>
                    </p>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
        <!-- /.login-box -->

        <!-- jQuery -->
        <script src="AdminModule/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="AdminModule/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="AdminModule/dist/js/adminlte.min.js"></script>
    </form>
</body>
</html>
