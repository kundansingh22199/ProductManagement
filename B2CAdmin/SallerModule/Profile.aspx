<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="B2CAdmin.SallerModule.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            margin-top: 20px;
            color: #1a202c;
            text-align: left;
            background-color: #e2e8f0;
        }

        .main-body {
            padding: 15px;
        }

        .card {
            box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 0 solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
        }

        .gutters-sm {
            margin-right: -8px;
            margin-left: -8px;
        }

            .gutters-sm > .col, .gutters-sm > [class*=col-] {
                padding-right: 8px;
                padding-left: 8px;
            }

        .mb-3, .my-3 {
            margin-bottom: 1rem !important;
        }

        .bg-gray-300 {
            background-color: #e2e8f0;
        }

        .h-100 {
            height: 100% !important;
        }

        .shadow-none {
            box-shadow: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Profile</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Profile</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /Breadcrumb -->

        <div class="row gutters-sm">

            <div class="col-md-12 border-1">
                <div class="alert alert alert-dismissible bg-success" runat="server" visible="false" id="messagebox">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Success!</strong>Data has been successfully Updated .
                </div>
                <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="messageboxerror">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Error!</strong> something wrong..!!&nbsp&nbsp&nbsp&nbsp
                    <span runat="server" id="errmsg"></span>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <asp:Image runat="server" ID="UserImg" class="img-size-50 img-circle" Style="height: 175px; width: 175px;" />
                            <div class="mt-3">
                                <h3><span runat="server" id="lblName"></span></h3>
                                <h6><span runat="server" id="lblUserType"></span></h6>
                                <p class="text-secondary mb-1">UserID : <span runat="server" id="lblUserId"></span></p>
                                <p class="text-muted font-size-sm">Password : <span runat="server" id="lblPassword"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="card mt-3">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-globe mr-2 icon-inline">
                                    <circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>Website</h6>
                            <span class="text-secondary">http://zappay.in</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github mr-2 icon-inline">
                                    <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>Github</h6>
                            <span class="text-secondary">kundansingh22199</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-twitter mr-2 icon-inline text-info">
                                    <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>Twitter</h6>
                            <span class="text-secondary">@KundanSingh</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-instagram mr-2 icon-inline text-danger">
                                    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>Instagram</h6>
                            <span class="text-secondary">@Mr_Kundan_0422</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">
                            <h6 class="mb-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-facebook mr-2 icon-inline text-primary">
                                    <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg>Facebook</h6>
                            <span class="text-secondary">@kundansingh22199</span>
                        </li>
                    </ul>
                </div>--%>
            </div>
            <div class="col-md-8 mb-3">
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0  font-weight-bold">Full Name</h6>
                            </div>
                            <div class="col-sm-4  mb-3 text-secondary" runat="server" id="lblFullName">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Date Of Birth</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblDob">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Phone</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblPhone">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Email</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblEmail">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Gender</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblGender">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Address</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblAddress">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Addhar No</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblAddhar">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Pan Card No</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblPan">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">State</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblState">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">City</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblCity">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">PinCode</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblPinCode">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Branch Name</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblBranch">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Store Name</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblStore">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">GstIn No</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblGstin">
                            </div>
                            <div class="col-sm-2 mb-3">
                                <h6 class="mb-0 font-weight-bold">Company Name</h6>
                            </div>
                            <div class="col-sm-4 mb-3 text-secondary" runat="server" id="lblCompany">
                            </div>
                            <div class="col-sm-6 text-right">
                                <asp:Button runat="server" ID="btnEdit" class="btn btn-primary pl-4 pr-4" Text="Edit" OnClick="btnEdit_Click" />
                            </div>
                            <%--<div class="col-sm-4">
                                <asp:Image runat="server" ID="addharBackImage" class="img-size-50" Style="height: 110px; width: 150px;" />
                            </div>
                            <div class="col-sm-4">
                                <asp:Image runat="server" ID="addharFrontImage" class="img-size-50" Style="height: 110px; width: 150px;" />
                            </div>
                            <div class="col-sm-4">
                                <asp:Image runat="server" ID="panCardImage" class="img-size-50" Style="height: 110px; width: 150px;" />
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade  bd-example-modal-xl" id="UserDetailsModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">
                <div class="modal-content" runat="server" id="divmodel">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align: center!important; font-family: serif">Profile Update</h5>
                        <button type="button" runat="server" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times</span>
                        </button>
                    </div>
                    <div class="modal-body" style="width: 97%; margin: auto; box-shadow: 0px 0px 5px 0px">
                        <div class="row gutters-sm">
                            <div class="col-md-4 border-1">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex flex-column align-items-center text-center">
                                            <asp:Image ID="UserImage1" runat="server" CssClass="img-circle" Style="height: 150px; width: 150px; border:1px solid black" />
                                            <asp:FileUpload runat="server" ID="UserUpload" Style="width: 96px; position: relative; top: -45px" onchange="loadFile(event)" />
                                            <div class="mt-1">
                                                <h3><span runat="server" id="txtprofileName"></span></h3>
                                                <h6><span runat="server" id="txtUserType"></span></h6>
                                                <p class="text-secondary mb-1">UserID : <span runat="server" id="profileId"></span></p>
                                                <p class="text-muted font-size-sm">Password : <span runat="server" id="profilePass"></span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="row">
                                    <div class="card" style="width: 100%">
                                        <div class="card-body" style="width: 95%;">
                                            <div class="col-md-12">
                                                <b>User Name :</b><asp:TextBox ID="txtUserName" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Mobile No :</b><asp:TextBox ID="txtMobile" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Email Id :</b><asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Gender :</b><asp:DropDownList ID="ddlGender" class="custom-select form-control-border mb-2" runat="server">
                                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Date of Birth :</b><asp:TextBox ID="txtDob" TextMode="Date" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <%--<div class="col-md-12">
                                        <b>AddharNo :</b><asp:TextBox ID="txtAddhar" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-md-12">
                                        <b>Pan No :</b><asp:TextBox ID="txtPan" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <b>Store Name :</b><asp:TextBox ID="txtStore" class="form-control" runat="server"></asp:TextBox>
                                    </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="row">
                                    <div class="card" style="width: 100%">
                                        <div class="card-body">
                                            <div class="col-md-12">
                                                <b>Address :</b><asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <b>State :</b><asp:DropDownList ID="ddlState" class="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <div class="col-md-12">
                                                <b>City :</b><asp:DropDownList ID="ddlCity" class="form-control" runat="server"></asp:DropDownList>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Pin Code :</b><asp:TextBox ID="txtPinCode" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12 text-right mt-4">
                                                <asp:Button runat="server" ID="btnUpdate" class="btn btn-primary p-2 pl-3 pr-3" Text="Update" OnClick="btnUpdate_Click" />
                                            </div>
                                            <%--<div class="col-md-z">
                                        <b>Branch Details :</b><asp:TextBox ID="txtBranch" class="form-control" runat="server"></asp:TextBox>
                                    </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <script>
            function ShowPopup() {
                debugger;
                $("#UserDetailsModel").modal("show");
                $("#UserDetailsModel").css('background', 'inherit');
            }

            var loadFile = function (event) {
                debugger;
                var image = document.getElementById('<%= UserImage1.ClientID %>');
                image.src = URL.createObjectURL(event.target.files[0]);
            };

            var m1;
            var f1 = document.getElementById("UserUpload");
            var v1 = document.getElementById("1");
            f1.addEventListener("change", function (e) {
                m1 = new FileReader();
                m1.onload = function (e) {
                    v1.src = e.target.result;
                };
                m1.readAsDataURL(this.files[0]);
            });
        </script>

    </div>
</asp:Content>
