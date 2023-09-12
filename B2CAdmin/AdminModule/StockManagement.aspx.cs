using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin.AdminModule
{
    public partial class StockManagement : System.Web.UI.Page
    {

        ClsProductMaster clsProduct = new ClsProductMaster();
        ClsStockMaster clsStock = new ClsStockMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCatogery();
                GetStockLists();
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
                int catogeryId = clsStock.GetCatogeryIdByProductCode(idValue);
                BindProductSize(catogeryId);
            }
            else
            {

            }
        }
        public void GetStockLists()
        {
            DataTable dt = clsStock.GetStockData();
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
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
                ddlProductSize.DataValueField = "Id";
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
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Yah!!', 'Sub Catogery Added ', 'Sucess')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
            }
        }
        protected void txtProductCode_TextChanged(object sender, EventArgs e)
        {
            int catogeryId = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
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
            DateTime ExpiryDate = Convert.ToDateTime(txtExpiryDate.Text.Trim());
            int TotalQuantity = 0;
            int SalesQuantity = 0;
            int AvilableQuantity = 0;
            int CreateBy = Convert.ToInt32(Session["UserId"]);
            int UpdateBy = 0;
            string action = "Insert";

            if (MrpPrice > PurchasePrice && MrpPrice > SalesPrice)
            {
                if (SalesPrice > PurchasePrice)
                {
                    int result = clsStock.AddStockData(txtProductCode.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, ProductQuantity, DiscountType, Discount,
                            TaxType, ddlProductSize.SelectedValue, MfgDate, ExpiryDate, TotalQuantity, SalesQuantity,
                    AvilableQuantity, CreateBy, UpdateBy, action);
                    if (result > 0)
                    {
                        GetStockLists();
                        messagebox.Visible = true;
                        messageboxerror.Visible = false;
                    }
                    else
                    {

                    }
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    error1.InnerText = "\t Sales Price Must be Gratter than Purchase Price ";
                    //Response.Write("<script>alert(Purchase Price Must be Gratter than Sales Price");
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
                error1.InnerText = "\t Mrp Price Must be Gratter than Purchase Price & Sales Price ";
                //Response.Write("<script>alert(Mrp Price Must be Gratter than Purchase Price");
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
            if (e.CommandName == "Details")
            {
                Label txtbox = (Label)e.Item.FindControl("lblProductCode");
                txtProductCode.Text = txtbox.Text;
                int catogeryId = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
                BindProductSize(catogeryId);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {

        }
        public void Clear()
        {
            txtProductCode.Text = txtPurchasePrice.Text = txtMrp.Text = txtSalesPrice.Text = txtQuantity.Text = txtDiscount.Text = txtMfgDate.Text = txtExpiryDate.Text = "";
            ddlTaxType.SelectedValue = ddlDiscountType.SelectedValue = ddlProductSize.SelectedValue = null;
            lblCgst.Text = lblIgst.Text = lblSgst.Text = "";
        }
    }
}