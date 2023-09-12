<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="B2CAdmin.AdminModule.StockManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    ]
    <style>
        
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Stock Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">Home</a></li>
                            <li class="breadcrumb-item active">Stock Management</li>
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
                                <h3 class="card-title">Stock Management</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-toggle="modal" data-target="#ProductAddModel">
                                        Add Product
                                    </button>
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
                                            <strong>Error!</strong>
                                            <span runat="server" id="error1"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label2">Product Code</asp:Label>
                                        <asp:TextBox runat="server" ID="txtProductCode" placeholder="Enter Product Code" class="form-control mb-2" OnTextChanged="txtProductCode_TextChanged" AutoPostBack="true" onkeypress="return isUrlValid(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label4">Product Size</asp:Label>
                                        <div class="input-group mb-2">
                                            <asp:DropDownList ID="ddlProductSize" class="custom-select form-control-border" runat="server">
                                            </asp:DropDownList>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                    <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#SizeModel"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label3">Product Quantity</asp:Label>
                                        <asp:TextBox runat="server" TextMode="Number" ID="txtQuantity" placeholder="Enter Product Quantity" class="form-control mb-2" onkeypress="return isNumber(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label7">Manufacturer Date </asp:Label>
                                        <asp:TextBox runat="server" TextMode="Date" ID="txtMfgDate" placeholder="Enter Manufacture Date" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label8">Expiry Date </asp:Label>
                                        <asp:TextBox runat="server" TextMode="Date" ID="txtExpiryDate" placeholder="Enter Expiry Date" class="form-control mb-2"></asp:TextBox>
                                    </div>
                                    <%--<div class="col-md-4">
                                        <asp:Label runat="server" ID="Labela">Product Name</asp:Label>
                                        <asp:TextBox runat="server" ID="txtProductname" placeholder="Enter Product Name" class="form-control"></asp:TextBox>
                                    </div>--%>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label1">MRP  Price</asp:Label>
                                        <asp:TextBox runat="server" ID="txtMrp" placeholder="Enter MRP Price" class="form-control mb-2" onkeypress="return isNumber(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label21">Purchase Price</asp:Label>
                                        <asp:TextBox runat="server" ID="txtPurchasePrice" placeholder="Enter Purchase Price" class="form-control mb-2" onkeypress="return isNumber(event)" oninput="CalculateFunction();"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label5">Discount </asp:Label>
                                        <div class="input-group mb-2">
                                            <asp:TextBox runat="server" ID="txtDiscount" placeholder="Enter Product Size" class="form-control" onkeypress="return isNumber(event)" oninput="CalculateFunction();"></asp:TextBox>

                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="padding: 0px; margin: 0px; display: block; height: 90%">
                                                    <asp:DropDownList ID="ddlDiscountType" class="custom-select form-control-border" runat="server" oninput="CalculateFunction();">
                                                        <asp:ListItem Text="PER" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="RS" Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label9">Tax Type</asp:Label>
                                        <div class="input-group  mb-2">
                                            <asp:DropDownList ID="ddlTaxType" class="custom-select form-control-border" runat="server" oninput="CalculateFunction();" AutoPostBack="true" OnSelectedIndexChanged="ddlTaxType_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                    <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#TaxModel"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Label runat="server" ID="Label6">CGST </asp:Label>
                                        <asp:Label runat="server" ID="lblCgst" class="form-control mb-2"></asp:Label>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Label runat="server" ID="Label13">SGST </asp:Label>
                                        <asp:Label runat="server" ID="lblSgst" placeholder="CGST" class="form-control mb-2"></asp:Label>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Label runat="server" ID="Label14">IGST </asp:Label>
                                        <asp:Label runat="server" ID="lblIgst" placeholder="CGST" class="form-control mb-2"></asp:Label>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Label runat="server" ID="Label22">Sales  Price</asp:Label>
                                        <asp:TextBox runat="server" ID="txtSalesPrice" placeholder="Enter Sales Price" class="form-control mb-2" onkeypress="return isUrlValid(event)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <asp:Button runat="server" ID="btnSubmit" Text="ADD STOCK" class="btn btn-primary mb-2" OnClick="btnSubmit_Click" />
                                <asp:Button runat="server" ID="btnUpdate" Text="UPDATE STOCK" class="btn btn-primary mb-2" OnClick="btnUpdate_Click" Visible="false" />
                                <asp:Button runat="server" ID="btnReset" Text="RESET" class="btn btn-danger mb-2" OnClick="btnReset_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <HeaderTemplate>
                                <div class="table-container">
                                    <div class="table-responsive" style="height: 400px; overflow: scroll;">
                                        <table class="table table-striped  table-bordered" style="border: 1px solid; width: 100%; height: 30px;">
                                            <tr style="background-color: #007bff; color: white">
                                                <th>SL/NO</th>
                                                <th>Product Code</th>
                                                <th>Sales Price</th>
                                                <th>Product Quantity</th>
                                                <th>Product Size</th>
                                                <th colspan="2">Operator</th>
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
                                        <asp:Label ID="lblSalesPrice" runat="server" Text='<%# Eval("SalesPrice") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductQuantity" runat="server" Text='<%# Eval("ProductQuantity") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProductSize" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>
                                        <asp:LinkButton ID="linkDetails" CommandName="Details" runat="server"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
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
                    </div>
                </div>
            </div>
            <!-- /.row -->
            <!-- Size Modal -->
            <div id="SizeModel" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-left" style="text-align: left; position: relative">Product Size</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:Label runat="server" ID="Label18" for="">Catogery Type</asp:Label>
                                    <asp:DropDownList ID="ddlCatogery" class="custom-select form-control-border mb-2" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label26" for="">Product Size</asp:Label>
                                    <asp:TextBox runat="server" ID="txtProductSize" placeholder="Enter Product Size" class="form-control mb-2"></asp:TextBox>
                                </div>
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label25" for="">Size Description</asp:Label>
                                    <asp:TextBox runat="server" ID="txtSizeDescription" placeholder="Enter Description Description" TextMode="MultiLine" class="form-control mb-2"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    <asp:Button runat="server" ID="btnSize" class="btn btn-primary" Text="ADD" OnClick="btnSize_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Size Modal End -->



            <!-- Size Modal -->
            <div id="TaxModel" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-left" style="text-align: left; position: relative">Add Tax</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label11" for="" placeholder="Enter CGST">CGST</asp:Label>
                                    <%--<input type="text" runat="server" id="txtCgst" oninput="myFunction()" class="form-control"/>--%>
                                    <asp:TextBox runat="server" ID="txtCgst" placeholder="Enter CGST" class="form-control mb-2" oninput="myFunction();"></asp:TextBox>
                                </div>
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label12" for="">SGST</asp:Label>
                                    <%--<input type="text" id="txtSgst" oninput="myFunction()" runat="server" placeholder="Enter SGST" class="form-control">--%>
                                    <asp:TextBox runat="server" ID="txtSgst" placeholder="Enter SGST" class="form-control mb-2" oninput="myFunction();"></asp:TextBox>
                                </div>
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label10" for="">IGST</asp:Label>
                                    <%--<input type="text" id="txtIgst" oninput="myFunction()" runat="server" placeholder="Calculate IGST" class="form-control">--%>
                                    <asp:TextBox runat="server" ID="txtIgst" class="form-control mb-2" onkeypress="return isUrlValid(event)"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    <asp:Button runat="server" ID="txtTaxAdd" class="btn btn-primary mb-2" Text="ADD" OnClick="txtTaxAdd_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Size Modal End -->

            <!-- Add Product Model -->
            <div class="modal fade  bd-example-modal-xl" id="ProductAddModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered  modal-xl" role="document">
                    <div class="modal-content" runat="server" id="divmodel">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle" style="text-align: center!important; font-family: serif">Add Product Details</h5>
                            <button type="button" runat="server" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times</span>
                            </button>
                        </div>
                        <div class="modal-body" style="width: 90%; margin: auto;">
                            <div class="container-fluid" style="box-shadow: 0px 0px 5px 0px; padding-left: 0px; padding-right: 0px">
                                <!-- general form elements -->
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <h3 class="card-title">Form</h3>
                                        <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <!-- /.card-header -->
                                    <!-- form start -->
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="alert alert alert-dismissible bg-success" runat="server" visible="false" id="Div1">
                                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                    <strong>Success!</strong>Data has been successfully Inserted .
                                                    <span runat="server" id="txtmess"></span>
                                                </div>
                                                <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="Div2">
                                                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                    <strong>Error!</strong> something wrong
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Label runat="server" ID="Label15" for="txtProductName">Product Name</asp:Label>
                                                <asp:TextBox runat="server" ID="txtProductName" placeholder="Enter Product Name" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Label runat="server" ID="Label16" for="txtSerialNo">SerialNo</asp:Label>
                                                <asp:TextBox runat="server" ID="txtSerialNo" placeholder="Enter SerialNo" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label runat="server" ID="Label17" for="ddlProductCatogery">Product Catogery</asp:Label>
                                                <div class="input-group mb-2">
                                                    <asp:DropDownList ID="ddlProductCatogery" AutoPostBack="true" class="custom-select form-control-border" runat="server">
                                                    </asp:DropDownList>
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                            <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#CatogryModel"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label runat="server" ID="Label19">Product Sub Catogery</asp:Label>
                                                <div class="input-group mb-2">
                                                    <asp:DropDownList ID="ddlProductSubCatogery" class="custom-select form-control-border" runat="server">
                                                    </asp:DropDownList>
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="padding: 0px; margin: 0px; padding-right: 10px; padding-left: 10px; display: block">
                                                            <i class="fas fa-plus" style="position: relative; top: 5px" data-toggle="modal" data-target="#SubCatogeryModel"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Label runat="server" ID="Label20" for="txtHsnCode">HSN Code</asp:Label>
                                                <asp:TextBox runat="server" ID="txtHsnCode" placeholder="Enter HSN Code" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4">
                                                <asp:Label runat="server" ID="Label23" for="txtBarCode">BarCode</asp:Label>
                                                <asp:TextBox runat="server" ID="txtBarCode" placeholder="Enter BarCode" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:Label runat="server" ID="Label24" for="txtProductDetails">Product Details</asp:Label>
                                                <asp:TextBox runat="server" ID="txtProductDetails" placeholder="Enter Product Details" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <asp:Label runat="server" ID="Label27" for="txtOtherDetails">Other Details</asp:Label>
                                                <asp:TextBox runat="server" ID="txtOtherDetails" placeholder="Enter Other Details" class="form-control mb-2"></asp:TextBox>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" ID="imgupload1" CssClass="form-control border-1 mb-2" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" CssClass="form-control border-1 mb-2" ID="imgupload2" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" CssClass="form-control border-1 mb-2" ID="imgupload3" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" CssClass="form-control border-1 mb-2" ID="imgupload4" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" CssClass="form-control border-1 mb-2" ID="imgupload5" />
                                            </div>
                                            <div class="col-md-4">
                                                <asp:FileUpload runat="server" CssClass="form-control border-1 mb-2" ID="imgupload6" />
                                            </div>
                                            <div class="col-md-12">
                                                <asp:Button runat="server" ID="Button1" Text="Submit" class="btn btn-primary mb-2" />
                                                <asp:Button runat="server" ID="Button2" Text="Reset" class="btn btn-danger mb-2" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.card-body -->
                            </div>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Product Model End -->

            <script>
                function myFunction() {
                    debugger
                    var A = parseFloat(document.getElementById('<%= txtCgst.ClientID %>').value);
                    var B = parseFloat(document.getElementById('<%= txtSgst.ClientID %>').value);
                    if (!isNaN(A) && isNaN(B)) {
                        document.getElementById('<%= txtIgst.ClientID %>').value = A;
                    }
                    else if (isNaN(A) && !isNaN(B)) {
                        document.getElementById('<%= txtIgst.ClientID %>').value = B;
                    }
                    else {
                        var C = A + B;
                        document.getElementById('<%= txtIgst.ClientID %>').value = C;
                    }
                }


                function CalculateFunction() {
                    debugger
                    var PurchasePrice = parseFloat(document.getElementById('<%= txtPurchasePrice.ClientID %>').value);
                    var Discount = parseFloat(document.getElementById('<%= txtDiscount.ClientID %>').value);
                    var TaxType = document.getElementById('<%= ddlTaxType.ClientID %>');
                    var selectedOption = TaxType.options[TaxType.selectedIndex];
                    var Tax = parseFloat(selectedOption.text);
                    var discountType = document.getElementById('<%= ddlDiscountType.ClientID %>').value;
                    var taxVal = document.getElementById('<%= ddlTaxType.ClientID %>').value;

                    var C = 0;
                    var SalesPrice = 0;
                    if (discountType == '1') {
                        C = PurchasePrice - ((PurchasePrice * Discount) / 100);
                        SalesPrice = C + ((C * Tax) / 100)
                    }
                    else if (discountType == '2') {
                        C = PurchasePrice - Discount;
                        SalesPrice = C + ((C * Tax) / 100)
                    }
                    else {
                        C = 0;
                    }
                    if (!isNaN(PurchasePrice) && isNaN(Discount) && isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = PurchasePrice);
                    }
                    if (isNaN(PurchasePrice) && !isNaN(Discount) && isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = 0);
                    }
                    if (isNaN(PurchasePrice) && isNaN(Discount) && !isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = 0);
                    }
                    if (isNaN(PurchasePrice) && !isNaN(Discount) && !isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = 0);
                    }
                    if (!isNaN(PurchasePrice) && isNaN(Discount) && !isNaN(Tax)) {
                        SalesPrice = PurchasePrice + ((PurchasePrice * Tax)/100)
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = SalesPrice);
                    }

                    if (!isNaN(PurchasePrice) && !isNaN(Discount) && isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = C);
                    }
                    if (!isNaN(PurchasePrice) && !isNaN(Discount) && !isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = SalesPrice);
                    }
                }

                document.getElementById('<%= txtSalesPrice.ClientID %>').readOnly = true
                document.getElementById('<%= txtProductCode.ClientID %>').readOnly = true


                function isUrlValid(e) {
                    const pattern = new RegExp(
                        '^(https?:\\/\\/)?' + // protocol
                        '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|' + // domain name
                        '((\\d{1,3}\\.){3}\\d{1,3}))' + // OR IP (v4) address
                        '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
                        '(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
                        '(\\#[-a-z\\d_]*)?$', // fragment locator
                        'i'
                    );
                    return pattern.test(e);
                }


                function isNumber(evt) {
                    evt = (evt) ? evt : window.event;
                    var charCode = (evt.which) ? evt.which : evt.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                        return false;
                    }
                    return true;
                }
            </script>
        </section>
        <!-- /.container-fluid -->

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</asp:Content>
