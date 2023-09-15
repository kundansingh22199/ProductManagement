﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
                GetStockLists();
                BindTaxType();
                GetValueFromQueryString();
                this.GetStockDataUsingPagnation(1);
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
            //DataTable dt = clsStock.GetStockData();
            //Repeater1.DataSource = dt;
            //Repeater1.DataBind();
            //Repeater2.DataSource = dt;
            //Repeater2.DataBind();
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
                        int result = clsStock.AddStockData(Id, txtProductCode.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, ProductQuantity, DiscountType, Discount,
                            TaxType, ddlProductSize.SelectedValue, MfgDate, ExpiryDate, CreateBy, UpdateBy, action);
                        if (result > 0)
                        {
                            GetStockLists();
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
                int catogeryId = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
                BindProductSize(catogeryId);
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
                    int catogeryId = clsStock.GetCatogeryIdByProductCode(txtProductCode.Text.Trim());
                    BindProductSize(catogeryId);
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
                    GetStockLists();
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
            DateTime ExpiryDate = Convert.ToDateTime(txtExpiryDate.Text.Trim());
            int CreateBy = Convert.ToInt32(Session["UserId"]);
            int UpdateBy = 0;
            string action = "Update";

            if (MrpPrice > PurchasePrice && MrpPrice > SalesPrice)
            {
                if (SalesPrice > PurchasePrice)
                {
                    int Id = Convert.ToInt32(ViewState["StockId"]);
                    int result = clsStock.AddStockData(Id, txtProductCode.Text.Trim(), PurchasePrice, MrpPrice, SalesPrice, ProductQuantity, DiscountType, Discount,
                            TaxType, ddlProductSize.SelectedValue, MfgDate, ExpiryDate, CreateBy, UpdateBy, action);
                    if (result > 0)
                    {
                        GetStockLists();
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
            txtProductCode.Text = txtPurchasePrice.Text = txtMrp.Text = txtSalesPrice.Text = txtQuantity.Text = txtDiscount.Text = txtMfgDate.Text = txtExpiryDate.Text = "";
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
                GetStockLists();
            }
            else
            {

            }
            
        }
        public void SearchDataById()
        {
            DataTable dt = clsStock.GetStockByProductCode(txtSearchProductCode.Text.Trim());
            if (dt.Rows.Count > 0)
            {
                Repeater1.DataSource=null;
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchDataById();
        }


        public void GetStockDataUsingPagnation(int PageIndex)
        {
            //DataTable dt = clsStock.GetStockDataUsingPagnation(PageIndex, PageSize);
            //if (dt.Rows.Count > 0)
            //{
            //    Repeater1.DataSource = dt;
            //    Repeater1.DataBind();
            //    int recordCount = Convert.ToInt32(dt.Rows.Count);
            //    this.PopulatePager(recordCount, PageIndex);
            //}

            ClsSqlConnection clscon = new ClsSqlConnection();

            using (SqlConnection con = new SqlConnection(clscon.GetConn()))
            {
                using (SqlCommand cmd = new SqlCommand("SP_GetStockPagination", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PageIndex", PageIndex);
                    cmd.Parameters.AddWithValue("@PageSize", PageSize);
                    cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
                    cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                    int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
                    this.PopulatePager(recordCount, PageIndex);
                }
            }
        }
        private void PopulatePager(int recordCount, int currentPage)
        {
            double dblPageCount = (double)((decimal)recordCount / Convert.ToDecimal(PageSize));
            int pageCount = (int)Math.Ceiling(dblPageCount);
            List<ListItem> pages = new List<ListItem>();
            if (pageCount > 0)
            {
                for (int i = 1; i <= pageCount; i++)
                {
                    pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
                }
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }
        protected void Page_Changed(object sender, EventArgs e)
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            this.GetStockDataUsingPagnation(pageIndex);
        }
    }
}