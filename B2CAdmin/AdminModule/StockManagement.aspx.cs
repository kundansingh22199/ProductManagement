using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin.AdminModule
{
    public partial class StockManagement : System.Web.UI.Page
    {
        private int PageSize = 5;
        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCatogery();
                GetStockLists(0);
                BindTaxType();
                GetValueFromQueryString();
            }
        }
        public void GetValueFromQueryString()
        {
            string idValue = HttpContext.Current.Request.QueryString["ProductCode"];

            if (!string.IsNullOrEmpty(idValue))
            {
                txtProductCode.Text = idValue;
                txtBrand.Text = "";
                DataTable dt = clsStock.GetCatogeryIdByProductCode(idValue);
                if (dt.Rows.Count > 0)
                {
                    int catogeryId = Convert.ToInt32(dt.Rows[0]["Catogery"]);
                    int Brand = Convert.ToInt32(dt.Rows[0]["Brand"]);
                    txtBrand.Text = clsStock.GetBrandName(Brand);
                    BindProductSize(catogeryId);
                }
            }
            else
            {

            }
        }
        public void BindTaxType()
        {
            DataTable dt = clsStock.GetTaxTypeData();
            ddlTaxType.DataSource = dt;
            ddlTaxType.DataTextField = "IGST";
            ddlTaxType.DataValueField = "Id";
            ddlTaxType.DataBind();
            ddlTaxType.Items.Insert(0, new ListItem { Text = "--Select--", Value = "" });
        }
        public void BindCatogery()
        {
            DataTable dt = clsProduct.GetCtogeryData();
            ddlCatogery.DataSource = dt;
            ddlCatogery.DataTextField = "CatogeryName";
            ddlCatogery.DataValueField = "Id";
            ddlCatogery.DataBind();
            ddlCatogery.Items.Insert(0, new ListItem { Text = "--Select--", Value = "" });
        }
        public void BindProductSize(int catogeryId)
        {
            DataTable dt = clsStock.GetSizeData(catogeryId);
            if (dt != null)
            {
                ddlProductSize.DataSource = dt;
                ddlProductSize.DataTextField = "Size";
                ddlProductSize.DataValueField = "SizeId";
                ddlProductSize.DataBind();
                ListItem selectItem = new ListItem("--Select--", "Selected");
                selectItem.Selected = true;
                ddlProductSize.Items.Insert(0, selectItem);
            }
        }
        protected void btnSize_Click(object sender, EventArgs e)
        {
            int result = 0;
            int catogeryId = Convert.ToInt32(ddlCatogery.SelectedValue);
            int userid = Convert.ToInt32(Session["UserId"]);
            result = clsStock.AddSizeData(txtProductSize.Text, txtSizeDescription.Text, catogeryId, userid);
            if (result > 0)
            {
                BindProductSize(catogeryId);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Yah!!', 'Sub Catogery Added ', 'Sucess')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
            }
        }
        protected void txtProductCode_TextChanged(object sender, EventArgs e)
        {
            DataTable dt = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
            int catogeryId = Convert.ToInt32(dt.Rows[0]["Catogery"]);
            BindProductSize(catogeryId);
            
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            decimal PurchasePrice = Convert.ToDecimal(txtPurchasePrice.Text.Trim());
            decimal MrpPrice = Convert.ToDecimal(txtMrp.Text.Trim());
            decimal SalesPrice = Convert.ToDecimal(txtSalesPrice.Text.Trim());
            int ProductQuantity = Convert.ToInt32(txtQuantity.Text.Trim());
            int DiscountType = Convert.ToInt32(ddlDiscountType.SelectedValue);
            decimal Discount = Convert.ToDecimal(txtDiscount.Text.Trim());
            int TaxType = Convert.ToInt32(ddlTaxType.SelectedValue);
            //decimal TxtAmount = Convert.ToDecimal(txtTax.Text.Trim());
            DateTime MfgDate = Convert.ToDateTime(txtMfgDate.Text.Trim());
            string ExpiryDate = txtExpiryDate.Text;
            if (ExpiryDate == null)
            {
                ExpiryDate = "";
            }
            int CreateBy = Convert.ToInt32(Session["UserId"]);
            int UpdateBy = 0;
            string action = "Insert";

            if (MrpPrice > PurchasePrice && MrpPrice > SalesPrice)
            {
                if (SalesPrice > PurchasePrice)
                {
                    int Id = 0;
                    DataTable dtStock = clsStock.GetStockDataByAllDetails(txtProductCode.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, DiscountType, Discount, TaxType, ddlProductSize.SelectedValue);
                    if (dtStock.Rows.Count > 0 && dtStock!=null)
                    {
                        messagebox.Visible = false;
                        messageboxerror.Visible = true;
                        error1.InnerText = "Product Already Added";
                    }
                    else
                    {
                        int result = clsStock.AddStockData(Id, txtProductCode.Text.Trim(),txtBrand.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, ProductQuantity, DiscountType, Discount,
                            TaxType, ddlProductSize.SelectedValue, MfgDate, ExpiryDate, CreateBy, UpdateBy, action);
                        if (result > 0)
                        {
                            GetStockLists(0);
                            messagebox.Visible = true;
                            messageboxerror.Visible = false;
                        }
                        else
                        {
                            messagebox.Visible = false;
                            messageboxerror.Visible = true;
                        }
                    }

                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    error1.InnerText = "\t Sales Price Must be Gratter than Purchase Price ";
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
                error1.InnerText = "\t Mrp Price Must be Gratter than Purchase Price & Sales Price ";
            }
        }
        protected void txtTaxAdd_Click(object sender, EventArgs e)
        {
            decimal Cgst = Convert.ToDecimal(txtCgst.Text.Trim());
            decimal Sgst = Convert.ToDecimal(txtSgst.Text.Trim());
            decimal Igst = Convert.ToDecimal(txtIgst.Text.Trim());
            int CreateBy = Convert.ToInt32(Session["UserId"]);
            int result = clsStock.AddTaxData(Cgst, Sgst, Igst, CreateBy);
            if (result > 0)
            {
                BindTaxType();
            }
            else
            {

            }
        }
        protected void ddlTaxType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int TxtTypeId = Convert.ToInt32(ddlTaxType.SelectedValue);
            DataTable dt = clsStock.GetTaxTypeDataById(TxtTypeId);
            if (dt.Rows.Count > 0)
            {
                lblCgst.Text = dt.Rows[0]["CGST"].ToString();
                lblSgst.Text = dt.Rows[0]["SGST"].ToString();
                lblIgst.Text = dt.Rows[0]["IGST"].ToString();
            }
        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName== "Stock")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                ViewState["StockId"] = txtId.Text.Trim();
                DataTable dt = clsStock.GetStockDataById(Convert.ToInt32(txtId.Text.Trim()));
                txtAvilableProduct.Text = dt.Rows[0]["ProductQuantity"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup();", true);
            }
            if (e.CommandName == "Details")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                ViewState["StockId"] = txtId.Text.Trim();
                DataTable dt = clsStock.GetStockDataById(Convert.ToInt32(txtId.Text.Trim()));
                Label txtbox = (Label)e.Item.FindControl("lblProductCode");
                txtProductCode.Text = txtbox.Text;
                DataTable dtCat = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
                int catogeryId = Convert.ToInt32(dtCat.Rows[0]["Catogery"]);
                BindProductSize(catogeryId);
                ddlProductSize.SelectedValue = dt.Rows[0]["ProductSize"].ToString();
                txtQuantity.Text = dt.Rows[0]["ProductQuantity"].ToString();
                txtBrand.Text = dt.Rows[0]["S_Brandname"].ToString();
                string mfgdate = dt.Rows[0]["MfgDate"].ToString();
                txtMfgDate.Text = Convert.ToDateTime(mfgdate).ToString("yyyy-MM-dd");
                string expiryDate = dt.Rows[0]["ExpiryDate"].ToString();
                txtExpiryDate.Text = Convert.ToDateTime(expiryDate).ToString("yyyy-MM-dd");
                txtMrp.Text = dt.Rows[0]["MrpPrice"].ToString();
                txtPurchasePrice.Text = dt.Rows[0]["PurchasePrice"].ToString();
                txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                ddlDiscountType.SelectedValue = dt.Rows[0]["DiscountType"].ToString();
                txtSalesPrice.Text = dt.Rows[0]["SalesPrice"].ToString();
                ddlTaxType.SelectedValue = dt.Rows[0]["TaxType"].ToString();
                int TxtTypeId = Convert.ToInt32(ddlTaxType.SelectedValue);
                DataTable dt1 = clsStock.GetTaxTypeDataById(TxtTypeId);
                if (dt1.Rows.Count > 0)
                {
                    lblCgst.Text = dt1.Rows[0]["CGST"].ToString();
                    lblSgst.Text = dt1.Rows[0]["SGST"].ToString();
                    lblIgst.Text = dt1.Rows[0]["IGST"].ToString();
                };
                btnUpdate.Visible = false;
                btnSubmit.Visible = true;

            }
            if (e.CommandName == "Update")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                DataTable dt = clsStock.GetStockDataById(Convert.ToInt32(txtId.Text.Trim()));
                if (dt.Rows.Count > 0)
                {
                    Label txtbox = (Label)e.Item.FindControl("lblProductCode");
                    txtProductCode.Text = txtbox.Text;
                    DataTable dtCat = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
                    int catogeryId = Convert.ToInt32(dtCat.Rows[0]["Catogery"]);
                    BindProductSize(catogeryId); ;
                    ddlProductSize.SelectedValue = dt.Rows[0]["ProductSize"].ToString();
                    txtQuantity.Text = dt.Rows[0]["ProductQuantity"].ToString();
                    string mfgdate = dt.Rows[0]["MfgDate"].ToString();
                    txtMfgDate.Text = Convert.ToDateTime(mfgdate).ToString("yyyy-MM-dd");
                    string expiryDate = dt.Rows[0]["ExpiryDate"].ToString();
                    txtExpiryDate.Text = Convert.ToDateTime(expiryDate).ToString("yyyy-MM-dd");
                    txtMrp.Text = dt.Rows[0]["MrpPrice"].ToString();
                    txtPurchasePrice.Text = dt.Rows[0]["PurchasePrice"].ToString();
                    txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                    ddlDiscountType.SelectedValue = dt.Rows[0]["DiscountType"].ToString();
                    txtSalesPrice.Text = dt.Rows[0]["SalesPrice"].ToString();
                    ddlTaxType.SelectedValue = dt.Rows[0]["TaxType"].ToString();
                    int TxtTypeId = Convert.ToInt32(ddlTaxType.SelectedValue);
                    DataTable dt1 = clsStock.GetTaxTypeDataById(TxtTypeId);
                    if (dt1.Rows.Count > 0)
                    {
                        lblCgst.Text = dt1.Rows[0]["CGST"].ToString();
                        lblSgst.Text = dt1.Rows[0]["SGST"].ToString();
                        lblIgst.Text = dt1.Rows[0]["IGST"].ToString();
                    };
                    ViewState["StockId"] = dt.Rows[0]["Id"].ToString();
                    btnUpdate.Visible = true;
                    btnSubmit.Visible = false;
                }
                else
                {
                    btnUpdate.Visible = false;
                    btnSubmit.Visible = true;
                }
            }
            if (e.CommandName == "Delete")
            {
                Label txtId = (Label)e.Item.FindControl("lblId");
                int Id = Convert.ToInt32(txtId.Text.Trim());
                int result = clsStock.DeleteProductById(Id);
                if (result > 0)
                {
                    GetStockLists(0);
                }
                else
                {

                }
            }
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            decimal PurchasePrice = Convert.ToDecimal(txtPurchasePrice.Text.Trim());
            decimal MrpPrice = Convert.ToDecimal(txtMrp.Text.Trim());
            decimal SalesPrice = Convert.ToDecimal(txtSalesPrice.Text.Trim());
            int ProductQuantity = Convert.ToInt32(txtQuantity.Text.Trim());
            int DiscountType = Convert.ToInt32(ddlDiscountType.SelectedValue);
            decimal Discount = Convert.ToDecimal(txtDiscount.Text.Trim());
            int TaxType = Convert.ToInt32(ddlTaxType.SelectedValue);
            //decimal TxtAmount = Convert.ToDecimal(txtTax.Text.Trim());
            DateTime MfgDate = Convert.ToDateTime(txtMfgDate.Text.Trim());
            string ExpiryDate = txtExpiryDate.Text;
            if (ExpiryDate == null)
            {
                ExpiryDate = "";
            }
            int CreateBy = Convert.ToInt32(Session["UserId"]);
            int UpdateBy = 0;
            string action = "Update";

            if (MrpPrice > PurchasePrice && MrpPrice > SalesPrice)
            {
                if (SalesPrice > PurchasePrice)
                {
                    int Id = Convert.ToInt32(ViewState["StockId"]);
                    int result = clsStock.AddStockData(Id, txtProductCode.Text.Trim(), txtBrand.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, ProductQuantity, DiscountType, Discount,
                            TaxType, ddlProductSize.SelectedValue, MfgDate, ExpiryDate, CreateBy, UpdateBy, action);
                    if (result > 0)
                    {
                        GetStockLists(0);
                        messagebox.Visible = true;
                        messageboxerror.Visible = false;
                    }
                    else
                    {
                        messagebox.Visible = false;
                        messageboxerror.Visible = true;
                        error1.Visible = false;
                    }
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    error1.InnerText = "\t Sales Price Must be Gratter than Purchase Price ";
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
                error1.InnerText = "\t Mrp Price Must be Gratter than Purchase Price & Sales Price ";
            }
        }
        public void Clear()
        {
            txtProductCode.Text = txtBrand.Text = txtPurchasePrice.Text = txtMrp.Text = txtSalesPrice.Text = txtQuantity.Text = txtDiscount.Text = txtMfgDate.Text = txtExpiryDate.Text = "";
            ddlTaxType.SelectedValue = ddlDiscountType.SelectedValue = ddlProductSize.SelectedValue = null;
            lblCgst.Text = lblIgst.Text = lblSgst.Text = "";
        }
        protected void btnAddStock_Click(object sender, EventArgs e)
        {
            int StockId = Convert.ToInt32(ViewState["StockId"]);
            int ProductQuantity = Convert.ToInt32(txtAvilableProduct.Text.Trim()) + Convert.ToInt32(txtAddProduct.Text.Trim());
            int UpdateBy = Convert.ToInt32(Session["UserId"]);
            int result = clsStock.UpdateStockById(ProductQuantity, UpdateBy, StockId);
            if (result > 0)
            {
                GetStockLists(0);
            }
            else
            {

            }
            
        }
        public void GetStockLists(int pagenumber)
        {
            try
            {
                DataTable dt = clsStock.GetStockData();

                if (dt.Rows.Count > 0)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    
                    if (txtSearch.Text.Trim() == "")
                    {
                        pgitems.DataSource = dt.DefaultView;
                        pgitems.AllowPaging = true;
                    }
                    else
                    {
                        DataTable dt1 = clsStock.SearchStockData(txtSearch.Text.Trim());
                        pgitems.DataSource = dt1.DefaultView;
                        pgitems.AllowPaging = true;
                    }

                    //control page size from here 
                    pgitems.PageSize = 5;
                    pgitems.CurrentPageIndex = pagenumber;
                    if (pgitems.PageCount > 1)
                    {
                        rptPaging.Visible = true;
                        ArrayList pages = new ArrayList();
                        for (int i = 0; i <= pgitems.PageCount - 1; i++)
                        {
                            pages.Add((i + 1).ToString());
                        }
                        rptPaging.DataSource = pages;
                        rptPaging.DataBind();
                    }
                    else
                    {
                        rptPaging.Visible = false;
                    }
                    Repeater1.DataSource = pgitems;
                    Repeater1.DataBind();
                    
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();
                }
            }
            catch
            {

            }
            finally
            {

            }
        }
        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            GetStockLists(pagenumber);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetStockLists(0);
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            DataTable dt = clsStock.GetStockData();
            StringBuilder csvData = new StringBuilder();

            // Add column headers
            csvData.AppendLine("Product Code,Mrp Price,Purchase Price,Sales Price,Discount,ProductQuantity,Size"); // Replace with your column names

            // Iterate through Repeater items and append data
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string ProductCode = dt.Rows[i]["ProductCode"].ToString(); // Replace with the actual control IDs
                string MrpPrice = dt.Rows[i]["MrpPrice"].ToString();
                string PurchasePrice = dt.Rows[i]["PurchasePrice"].ToString();
                string SalesPrice = dt.Rows[i]["SalesPrice"].ToString();
                string Discount = dt.Rows[i]["Discount"].ToString();
                string ProductQuantity = dt.Rows[i]["ProductQuantity"].ToString();
                string Size = dt.Rows[i]["Size"].ToString();

                // Append data to the CSV string
                csvData.AppendLine($"{ProductCode},{MrpPrice},{PurchasePrice},{SalesPrice},{Discount},{ProductQuantity},{Size}");
            }

            // Send the data as a CSV file to the client
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/csv";
            Response.AddHeader("content-disposition", "attachment;filename=data.csv");
            Response.Charset = "";
            Response.Output.Write(csvData.ToString());
            Response.End();
        }
    }
}