<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="B2CAdmin.AdminModule.AddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<style type="text/css">
        .col-md-12 {
            padding:10px;
        }
         .col-md-3{
             padding:10px;
         }
         .col-md-6{
             padding:10px;
         }
         .col-md-4{
             padding:10px;
         }
    </style>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Add User</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Add User</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-12">
                        <!-- general form elements -->
                        <div class="card card-primary">
                            <div class="card-header">
                                <h3 class="card-title">Add User</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="alert alert alert-dismissible bg-success" runat="server" visible="false" id="messagebox">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <strong>Success!</strong>Data has been successfully Inserted .
                                            <span runat="server" id="txtPass"></span>
                                        </div>
                                        <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="messageboxerror">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <strong>Error!</strong> something wrong
                                            <span runat="server" id="errmsg"></span>
                                        </div>
                                    </div>
                                    <%--<div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label2">User ID</asp:Label>
                                        <asp:TextBox runat="server" ID="txtUserId" placeholder="Enter UserId" class="form-control mb-2"></asp:TextBox>
                                    </div>--%>
                                    <%--<div class="col-md-4">
                                        <asp:Label runat="server" ID="Label4">Password</asp:Label>
                                        <asp:TextBox runat="server" ID="txtPasword" placeholder="Enter Password" class="form-control"></asp:TextBox>
                                    </div>--%>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label1">Name<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtUserName" placeholder="Enter User Name" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label runat="server" ID="Label5">User Type<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:DropDownList ID="ddlUserType" class="custom-select form-control-border mb-2" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label8">State<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:DropDownList ID="ddlState" AutoPostBack="true" class="custom-select form-control-border mb-2" runat="server" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label9">City<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:DropDownList ID="ddlCity" class="custom-select form-control-border mb-2" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label10">Pincode<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtPinCode" onkeypress="return isNumber(event)" MaxLength="6" placeholder="Enter Pin Code" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label7">Address<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtAddress" placeholder="Enter Address" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label3">Addhar Card<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" MaxLength="12" ID="txtAadhar" onkeypress="return isNumber(event)" placeholder="Enter Addhar Card" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label6" for="txtPanCard">Pan Card<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" MaxLength="10" ID="txtPanCard" placeholder="Enter Pan Card" class="form-control mb-2"></asp:TextBox>
                                    </div>

                                    
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label11">GSTIN<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtGstIn" placeholder="Enter GstIn" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label12">User Image<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:FileUpload ID="UserImage" class="form-control mb-2" runat="server" />
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label13">Addhar Font Image<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:FileUpload ID="AddharImage" class="form-control mb-2" runat="server" />
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label4">Addhar Back Image<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:FileUpload ID="AddharImage2" class="form-control mb-2" runat="server" />
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label14">Pan Card Image<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:FileUpload ID="PanImage" class="form-control mb-2" runat="server" />
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label15">Mobile No<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtMobileNo" onkeypress="return isNumber(event)" placeholder="Enter Mobile No" MaxLength="10" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label16">Email-ID<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtEmail" placeholder="Enter Email Id" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label18">Date of Birth<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtDob" TextMode="Date" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label17">Company Name<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtCompanyName" placeholder="Enter Company Name" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label19">Store Name<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtStore" placeholder="Enter Store Name" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label20">Branch Details<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtBranch" placeholder="Enter Branch Details" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <asp:Button runat="server" ID="btnSubmit" Text="Submit" class="btn btn-primary mb-2 ml-2" OnClick="btnSubmit_Click" />
                                <asp:Button runat="server" ID="btnUpdate" Text="UPDATE USER" class="btn btn-primary mb-2 ml-2" Visible="false" OnClick="btnUpdate_Click"/>
                                <asp:Button runat="server" ID="btnReset" Text="RESET" class="btn btn-danger mb-2 ml-2 mr-2" OnClick="btnReset_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->

        </section>
        <!-- /.container-fluid -->

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</asp:Content>
