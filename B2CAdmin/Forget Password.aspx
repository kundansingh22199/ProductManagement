<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forget Password.aspx.cs" Inherits="B2CAdmin.Forget_Password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forget Password</title>
     <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback"/>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="AdminModule/plugins/fontawesome-free/css/all.min.css"/>
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="AdminModule/plugins/icheck-bootstrap/icheck-bootstrap.min.css"/>
    <!-- Theme style -->
    <link rel="stylesheet" href="AdminModule/dist/css/adminlte.min.css"/>
    <link rel="stylesheet" href="AdminModule/dist/css/adminlte.css" />
</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
        <div class="login-box">
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="Default.aspx" class="h1"><b>Change</b>Password</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">You are only one step a way from your new password, recover your password now.</p>
      <div class="input-group mb-3">
          <asp:TextBox runat="server" class="form-control" ID="txtUserId" placeholder="Enter UserId"></asp:TextBox>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
            <asp:TextBox runat="server" class="form-control" ID="txtPassword" placeholder="Enter Password"></asp:TextBox>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
            <asp:TextBox runat="server" class="form-control" ID="txtConfirmPassword" placeholder="Enter Confirm Password"></asp:TextBox>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
              <asp:Button ID="btnSubmit" runat="server" class="btn btn-primary btn-block" Text="Change Password" OnClick="btnSubmit_Click" />
          </div>
          <!-- /.col -->
        </div>

      <p class="mt-3 mb-1">
        <a href="Default.aspx">Login</a>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
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
