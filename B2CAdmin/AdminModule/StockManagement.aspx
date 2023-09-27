<%@ Page Title="" Language="C#" MasterPageFile="~/AdminModule/Master.Master" AutoEventWireup="true" CodeBehind="StockManagement.aspx.cs" Inherits="B2CAdmin.AdminModule.StockManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
                                            <strong>Success!</strong>Successfully Operation.
                                            <span runat="server" id="txtPass"></span>
                                        </div>
                                        <div class="alert alert alert-dismissible bg-danger" runat="server" visible="false" id="messageboxerror">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <strong>Error!</strong>
                                            <span runat="server" id="error1"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label2">Product Code<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtProductCode" placeholder="Enter Product Code" class="form-control mb-2" OnTextChanged="txtProductCode_TextChanged" AutoPostBack="true" onkeypress="return isUrlValid(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label16">Brand Name<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtBrand" placeholder="Enter Brand Name" class="form-control mb-2" onkeypress="return isUrlValid(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label4">Product Size<span style="color:red"><b>*</b></span></asp:Label>
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
                                        <asp:Label runat="server" ID="Label3">Product Quantity<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" TextMode="Number" ID="txtQuantity" placeholder="Enter Product Quantity" class="form-control mb-2" onkeypress="return isNumber(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label7">Manufacturer Date<span style="color:red"><b>*</b></span> </asp:Label>
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
                                        <asp:Label runat="server" ID="Label1">MRP  Price<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtMrp" placeholder="Enter MRP Price" class="form-control mb-2" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label21">Purchase Price<span style="color:red"><b>*</b></span></asp:Label>
                                        <asp:TextBox runat="server" ID="txtPurchasePrice" placeholder="Enter Purchase Price" class="form-control mb-2" onkeypress="return isNumber(event)" oninput="CalculateFunction();"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label runat="server" ID="Label5">Discount<span style="color:red"><b>*</b></span> </asp:Label>
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
                                        <asp:Label runat="server" ID="Label9">Tax Type<span style="color:red"><b>*</b></span></asp:Label>
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
                    <div class="col-md-3">
                        <asp:TextBox runat="server" ID="txtSearch"  placeholder="Search Here....!!" class="form-control" OnTextChanged="btnSearch_Click" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <div class="input-group mb-2">
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                    <div class="col-md-7 text-right">
                        <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Export In Excel" OnClick="btnExcelExport_Click"/>
                    </div>
                    <div class="col-md-12">
                        <table class="table table-striped  table-bordered" id="myTable1" style="border: 1px solid; height: 30px; width: 100%; overflow-x: scroll;">
                            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                <HeaderTemplate>
                                    <thead>
                                        <tr style="background-color: #007bff; color: white">
                                            <th>SL/NO</th>
                                            <th>Product Code</th>
                                            <th>Brand</th>
                                            <th>Name</th>
                                            <th>MRP Price</th>
                                            <th>Sales Price</th>
                                            <th>Quantity</th>
                                            <th>Product Size</th>
                                            <th colspan="4">Action</th>
                                        </tr>
                                    </thead>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tbody class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800"  style="font-size:90%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSNo" runat="server" Text='<%#  Container.ItemIndex + 1 %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblProductCode" runat="server" Text='<%# Eval("ProductCode") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label17" runat="server" Text='<%# Eval("S_BrandName") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label15" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label28" runat="server" Text='<%#string.Format("{0:n2}",Eval("MrpPrice")) %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSalesPrice" runat="server" Text='<%#string.Format("{0:n2}",Eval("SalesPrice")) %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblProductQuantity" runat="server" Text='<%# Eval("ProductQuantity") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblProductSize" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="LinkButton1" CommandName="Stock" runat="server"><i class="fas fa-plus fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Visible="false"></asp:Label>
                                                <asp:LinkButton ID="linkDetails" CommandName="Details" runat="server"><i class="fa fa-eye fa-xl" aria-hidden="true" style="font-size:25px"></i> </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="linkUpdate" CommandName="Update" runat="server"><i class="fas fa-edit fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="LinkButton2" CommandName="Delete" runat="server" OnClientClick="return confirm('Are you sure, you want to delete this Stock?');"><i class="fas fa-trash fa-xl" style="font-size:25px"></i> </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </tbody>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                        <div style="overflow: hidden;">
                            <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnPage" CssClass="btn btn-primary" CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" ForeColor="White" Font-Bold="True"><%# Container.DataItem %></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
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
            <!-- Gst Modal -->
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
            <!-- Gst Modal End -->
            <!-- Stock Modal -->
            <div id="AddStockModel" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-left" style="text-align: left; position: relative">Add Stock</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <asp:Label runat="server" ID="Label29" for="">Avilable Product</asp:Label>
                                    <asp:TextBox runat="server" ID="txtAvilableProduct" ReadOnly="true" class="form-control mb-2"></asp:TextBox>
                                </div>
                                <div class="col-md-12">
                                    <asp:Label runat="server" ID="Label32" for="">Add Product Size</asp:Label>
                                    <asp:TextBox runat="server" ID="txtAddProduct" placeholder="Enter Product Size" class="form-control mb-2"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    <asp:Button runat="server" ID="btnAddStock" class="btn btn-primary" Text="ADD" OnClick="btnAddStock_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Stock Modal End -->

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
                        SalesPrice = PurchasePrice + ((PurchasePrice * Tax) / 100)
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = SalesPrice);
                    }

                    if (!isNaN(PurchasePrice) && !isNaN(Discount) && isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = C);
                    }
                    if (!isNaN(PurchasePrice) && !isNaN(Discount) && !isNaN(Tax)) {
                        parseFloat(document.getElementById('<%= txtSalesPrice.ClientID %>').value = SalesPrice);
                    }
                }

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

                function ShowPopup() {
                    debugger;
                    $("#AddStockModel").modal("show");
                    $("#AddStockModel").css('background', 'inherit');
                }

                function Search_Repeater(strKey) {
                    debugger;
                    var strData = strKey.value.toLowerCase().split(" ");
                    var tblData = document.getElementById("myTable1");
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
                document.getElementById('<%= txtSalesPrice.ClientID %>').readOnly = true
                document.getElementById('<%= txtProductCode.ClientID %>').readOnly = true
                document.getElementById('<%= txtBrand.ClientID %>').readOnly = true
            </script>

            <script src="jquery-1.10.2.js" type="text/javascript"></script>
        </section>
        <!-- /.container-fluid -->

        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</asp:Content>
