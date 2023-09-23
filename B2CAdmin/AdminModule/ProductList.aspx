<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="B2CAdmin.AdminModule.ProductList" %>

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
                                                <th>
                                                    <asp:Label ID="headsl" runat="server" Text="SL/NO"></asp:Label></th>
                                                <th>Product Image</th>
                                                <th>Product Code</th>
                                                <th>Product Name</th>
                                                <th>Serial No</th>
                                                <th>Catogery</th>
                                                <th>Sub Catogery</th>
                                                <th colspan="4">
                                                    <asp:Label ID="headop" runat="server" Text="Operator"></asp:Label></th>

                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Image ID="lblProductImage" runat="server" ImageUrl='<%# Eval("ProductImage1") %>' class="img-size-50 img-circle" Style="height: 36px; width: 36px;"></asp:Image>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("CatogeryName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("SubCatogeryName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("id") %>' Visible="false"></asp:Label>
                                        <asp:LinkButton ID="linkDetails" CommandName="Details" runat="server"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="linkUpdate" CommandName="Update" runat="server"><i class="fas fa-edit fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" CommandName="Delete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this Product?');"><i class="fas fa-trash fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton2" CommandName="Stock" runat="server">
                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/AdminModule/dist/img/inventory.png" Style="height: 35px; width: 35px;" />
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                            </div></div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div style="overflow: hidden;">
                            <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnPage" CssClass="btn btn-primary" CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" ForeColor="White" Font-Bold="True"><%# Container.DataItem %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="modal fade  bd-example-modal-sm" id="ProductDetailsModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">
                                <div class="modal-content" runat="server" id="divmodel">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLongTitle" style="text-align: center!important; font-family: serif">Product Details</h5>
                                        <button type="button" runat="server" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" style="width: 90%; margin: auto; box-shadow: 0px 0px 5px 0px">
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-sm-7">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <b>Product Code :</b><asp:Label ID="lblProductCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Product Name :</b><asp:Label ID="lblProductName" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <b>Catogery :</b><asp:Label ID="lblCatogery" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <b>Sub Catogery :</b><asp:Label ID="lblSubCatogery" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Bar Code :</b><asp:Label ID="lblBarCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>HSN Code :</b><asp:Label ID="lblHsnCode" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Product Details :</b><asp:Label ID="lblProductDetails" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Serial No :</b><asp:Label ID="lblSerialNo" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <b>Other Details :</b><asp:Label ID="lblOtherDetails" class="form-control" runat="server"></asp:Label>
                                                        </div>
                                                        <%--<div class="col-sm-6">
                                                            <b>Create Date :</b><asp:Label ID="lblCreateDate" class="form-control" runat="server"></asp:Label>
                                                        </div>--%>
                                                        <div class="col-sm-6">
                                                            <asp:Label ID="lblProductId" class="form-control" runat="server" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-sm-5">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                                                <div class="carousel-inner">
                                                                    <div class="carousel-item active">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image1" alt="Product Image 1" data-active="active" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                    <div class="carousel-item">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image2" alt="Product Image 2" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                    <div class="carousel-item">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image3" alt="Product Image 3" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                    <div class="carousel-item">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image4" alt="Product Image 4" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                    <div class="carousel-item">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image5" alt="Product Image 5" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                    <div class="carousel-item">
                                                                        <asp:Image class="img-fluid d-block" runat="server" ID="image6" alt="Product Image 6" Style="width: 100%; height: 200px" />
                                                                    </div>
                                                                </div>
                                                                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev" style="color: red; background: red; height: 25px; width: 35px; position: absolute; top: 95%"><span class="carousel-control-prev-icon" aria-hidden="true"></span><span class="sr-only">Previous</span></a>
                                                                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next" style="color: red; background: red; height: 25px; width: 35px; position: absolute; top: 95%"><span class="carousel-control-next-icon" aria-hidden="true"></span><span class="sr-only">Next</span></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
                                $("#ProductDetailsModel").modal("show");
                                $("#ProductDetailsModel").css('background', 'inherit');
                            }

                        </script>
                    </div>
                    <div class="col-md-12" runat="server" id="dv1" visible="false">
                        <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>SL/NO</th>
                                                <th>Product Code</th>
                                                <th>Product Name</th>
                                                <th>Product Serial No</th>
                                                <th>HSN Code</th>
                                                <th>Bar Code</th>
                                                <th>Product Details</th>
                                                <th>Other Details</th>
                                            </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("HSNCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("BarCode") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("ProductDetails") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("OtherDetails") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                                            </div></div>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script>
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
</asp:Content>
