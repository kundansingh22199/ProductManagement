<%@ Page Title="" Language="C#" MasterPageFile="~/SallerModule/SallerMaster.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="B2CAdmin.SallerModule.ProductList" %>

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
                        <h1>Product List</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Product List</li>
                        </ol>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-2">
                        <asp:DropDownList runat="server" ID="ddlCatogery" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCatogery_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList runat="server" ID="ddlSubCatogery" CssClass="form-control" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox runat="server" ID="txtSearch" placeholder="Search Here....!!" class="form-control" AutoPostBack="true" OnTextChanged="btnSearch_Click" onkey></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-4 text-right">
                        <asp:Button runat="server" ID="btnExportInExcel" CssClass="btn btn-primary" Text="Export to excel" />
                    </div>
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <table id="bootstrap-data-table-export" class="table table-bordered ">
                                    <thead style="background: black; color: white">
                                        <tr>
                                            <th>
                                                <asp:Label ID="Label1" runat="server" Text="SL/NO"></asp:Label></th>
                                            <th>Image</th>
                                            <th>Product Code</th>
                                            <th>Brand</th>
                                            <th>Name</th>
                                            <th>Size</th>
                                            <th>Mrp Price</th>
                                            <th>Sales Price</th>
                                            <th colspan="2">
                                                <asp:Label ID="Label2" runat="server" Text="Operator"></asp:Label>
                                            </th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Image ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="user-avatar rounded-circle" Style="height: 36px; width: 36px;"></asp:Image>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBrand" runat="server" Text='<%# Eval("S_BrandName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text='<%#string.Format("{0:n2}",Eval("MrpPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text='<%#string.Format("{0:n2}",Eval("SalesPrice")) %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>
                                            <asp:LinkButton ID="linkDetails" CommandName="Order" runat="server" CssClass="text-dark"><i class="fa fa-shopping-cart fa-xl" aria-hidden="true" style="font-size:30px"></i> </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton2" CommandName="Cancle" runat="server" CssClass="text-dark" OnClientClick="return confirm('Are you sure you want to Cancle this Order?');">
                                                <i class="fas fa-times-circle fa-xl" aria-hidden="true" style="font-size:30px"></i>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div style="overflow: hidden;">
                            <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnPage" CssClass="btn btn-dark" CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" ForeColor="White" Font-Bold="True"><%# Container.DataItem %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                    </div>

                </div>
            </div>
        </section>
    </div>
    <!-- Product Modal -->
    <div id="ProductModel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg ">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-left" style="text-align: left; position: relative">Product Order</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:Label runat="server" ID="Label29" for="">Product Name</asp:Label>
                            <asp:TextBox runat="server" ID="txtProductName" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label32" for="">Serial No</asp:Label>
                            <asp:TextBox runat="server" ID="txtSerialNo" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label7" for="">HSN Code</asp:Label>
                            <asp:TextBox runat="server" ID="txtHsnCode" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label11" for="">Size/Weight</asp:Label>
                            <asp:TextBox runat="server" ID="txtSize" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label8" for="">Mrp Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtMrpPrice" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label13" for="">Discount</asp:Label>
                            <asp:TextBox runat="server" ID="txtDiscount" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label14" for="">Tax</asp:Label>
                            <asp:TextBox runat="server" ID="txtTax" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label4" for="">Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtPrice" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label9" for="">Quantity</asp:Label>
                            <asp:TextBox runat="server" ID="txtQuantity" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="Label10" for="">Total Price</asp:Label>
                            <asp:TextBox runat="server" ID="txtTotalPrice" class="form-control mb-2"></asp:TextBox>
                        </div>
                        <div class="col-sm-6">
                            <asp:Image ID="ReceiptImage" runat="server" CssClass="img-fluid" Style="height: 150px; width: 100%;" />
                        </div>
                        <div class="col-sm-6">
                            <asp:Label runat="server" ID="Label12" for="">Payment Reciept</asp:Label>
                            <asp:FileUpload runat="server" ID="ReceiptUpload" onchange="loadFile(event)" CssClass="form-control my-auto" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnOrderProduct" class="btn btn-primary" Text="Order" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Product Modal End -->
    <script>
        function ShowOrderPopup() {
            debugger;
            $("#ProductModel").modal("show");
            $("#ProductModel").css('background', 'inherit');
        }
        var loadFile = function (event) {
            debugger;
            var image = document.getElementById('<%= ReceiptImage.ClientID %>');
            image.src = URL.createObjectURL(event.target.files[0]);
        };
        var m1;
        var f1 = document.getElementById("ReceiptUpload");
        var v1 = document.getElementById("1");
        f1.addEventListener("change", function (e) {
            m1 = new FileReader();
            m1.onload = function (e) {
                v1.src = e.target.result;
            };
            m1.readAsDataURL(this.files[0]);
        });
    </script>
</asp:Content>
