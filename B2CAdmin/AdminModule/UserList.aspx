<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="B2CAdmin.AdminModule.UserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>User List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">User List</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ID="txtSearch"  placeholder="Search Here....!!" class="form-control" OnTextChanged="btnSearch_Click" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-7 text-right">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" OnClick="btnExportInExcel_Click" Text="Export to excel" />
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" id="myTable" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>SL/NO</th>
                                                <th>User Image</th>
                                                <th>User Name</th>
                                                <th>User Id</th>
                                                <th>User Type</th>
                                                <th>Mobile No</th>
                                                <th>Email-Id</th>
                                                <th colspan="3">Operator</th>
                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Image ID="Label3" runat="server" ImageUrl='<%# Eval("UserImage") %>' class="img-size-50 img-circle" Style="height: 36px; width: 36px;"></asp:Image>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSchemeName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("UserId") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblUserType" runat="server" Text='<%# Eval("UserTypeName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Emailid") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                                        <asp:LinkButton ID="linkDetails" CommandName="Details" runat="server"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" CommandName="Delete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this User?');"><i class="fas fa-trash fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="linkUpdate" CommandName="Update" runat="server"><i class="fas fa-edit fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                 </div>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div style="overflow: hidden;">
                            <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnPage" CssClass="btn btn-primary" CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" ForeColor="White" Font-Bold="True"><%# Container.DataItem %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="modal fade  bd-example-modal-xl" id="UserDetailsModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">
                                <div class="modal-content" runat="server" id="divmodel">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align: center!important; font-family: serif">User Details</h5>
                                        <button type="button" runat="server" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" style="width: 90%; margin: auto; box-shadow: 0px 0px 5px 0px">
                                        <table border="1" style="width: 100%; margin: auto; height: 300px" id="tableReceve">
                                            <tr style="border: 1px">
                                                <td><b>User Name :</b><asp:Label ID="lblUserName" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>UserId :</b><asp:Label ID="lblUserId" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Mobile No :</b><asp:Label ID="lblMobile" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Gender :</b><asp:Label ID="lblGender" class="form-control" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr style="border: 1px">
                                                <td><b>Email Id :</b><asp:Label ID="lblEmail" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Date of Birth :</b><asp:Label ID="lblDob" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Company Name :</b><asp:Label ID="lblCompany" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>UserType :</b><asp:Label ID="lblUserType" class="form-control" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr style="border: 1px">
                                                <td><b>Address :</b><asp:Label ID="lblAddress" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>GSTIN :</b><asp:Label ID="lblGstIn" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>AddharNo :</b><asp:Label ID="lblAddharNo" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Pan No :</b><asp:Label ID="lblPanNo" class="form-control" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr style="border: 1px">
                                                <td><b>Branch Details :</b><asp:Label ID="lblBranchDetails" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Store Name :</b><asp:Label ID="lblStoreName" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Password :</b><asp:Label ID="lblPassword" class="form-control" runat="server"></asp:Label></td>
                                                <td><b>Create Date :</b><asp:Label ID="lblCreateDate" class="form-control" runat="server"></asp:Label></td>
                                            </tr>
                                            <%--<tr style="border: 1px">
                                                <td><b>Update Date :</b><asp:Label ID="lblUpdateDate" class="form-control" runat="server"></asp:Label></td>
                                            </tr>--%>
                                            <tr style="border: 1px; width: auto">
                                                <td><b>User Image </b>
                                                    <br />
                                                    <asp:Image ID="UserImage" CssClass="img img-fluid" runat="server" Style="height: 100px; width: 100px" /></td>
                                                <td><b>Addhar Font Image </b>
                                                    <br />
                                                    <asp:Image ID="AddharImage" CssClass="img img-fluid" runat="server" Style="height: 100px; width: 150px" /></td>
                                                <td><b>Addhar Back Image </b>
                                                    <br />
                                                    <asp:Image ID="AddharImage2" CssClass="img img-fluid" runat="server" Style="height: 100px; width: 150px" /></td>
                                                <td><b>Pan Card Image </b>
                                                    <br />
                                                    <asp:Image ID="PanImage" CssClass="img img-fluid" runat="server" Style="height: 100px; width: 150px" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnPrint" runat="server" class="btn btn-secondary" Text="Print" OnClick="btnPrint_Click" />
                                        <asp:Button ID="Btn_back" runat="server" class="btn btn-success" Text="Go Back" OnClick="Btn_back_Click" />
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

                            function Search_Repeater(strKey) {
                                debugger;
                                var strData = strKey.value.toLowerCase().split(" ");
                                var tblData = document.getElementById("myTable");
                                var rowData;
                                for (var i = 1; i < tblData.rows.length; i++) {
                                    rowData = tblData.rows[i].innerHTML;
                                    var styleDisplay = 'none';
                                    for (var j = 0; j < strData.length; j++) {
                                        if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                                            styleDisplay = '';
                                        else {
                                            styleDisplay = 'none';
                                            break;
                                        }
                                    }
                                    tblData.rows[i].style.display = styleDisplay;
                                }
                            }

                        </script>

                    </div>


                    <div class="col-md-12" runat="server" id="ddvv" visible="false">
                        <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>SL/NO</th>
                                                <th>User Name</th>
                                                <th>Gender</th>
                                                <th>User Id</th>
                                                <th>User Type</th>
                                                <th>Mobile No</th>
                                                <th>Email-Id</th>
                                                <th>Company Name</th>
                                                <th>Password</th>
                                                <th>Status</th>
                                                <th>Address</th>
                                                <th>AadharNo</th>
                                                <th>Pan Card No</th>
                                                <th>GstIn No</th>
                                                <th>Store Name</th>
                                                <th>Branch Details</th>
                                                <th>Date of Birth</th>
                                                <th>State</th>
                                                <th>City</th>
                                                <th>Pin Code</th>
                                                <th>Create Date</th>

                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSchemeName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label18" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("UserId") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblUserType" runat="server" Text='<%# Eval("UserType") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Emailid") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("AadharNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("PanNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("GstinNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("StoreName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("BranchDetails") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label13" runat="server" Text='<%# Eval("Dob") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label14" runat="server" Text='<%# Eval("State") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label15" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("PinCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label17" runat="server" Text='<%# Eval("CreateOn") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                 </div>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
