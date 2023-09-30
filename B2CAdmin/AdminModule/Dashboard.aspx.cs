using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        ClsProfileMaster clsProfile = new ClsProfileMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDashboardDetails();
            }
        }
        public void GetDashboardDetails()
        {
            int TotalSales = clsProfile.GetTotalSales();
            int TotalPendinsSales = clsProfile.GetTotalPendingSales();
            int TotalCancleSales = clsProfile.GetTotalCancleSales();
            int TotalSellar = clsProfile.GetTotalSaller();
            int TotalItems = clsProfile.GetTotalItems();
            int TotalCustomer = clsProfile.GetTotalCustomer();
            lblTotalSales.InnerText = TotalSales.ToString();
            lblTotalItems.InnerText = TotalItems.ToString();
            lblTotalSupplier.InnerText = TotalSellar.ToString();
            lblTotalPending.InnerText = TotalPendinsSales.ToString();
            lblTotalCancle.InnerText = TotalCancleSales.ToString();
            lblTotalCustomer.InnerText = TotalCustomer.ToString();
        }
    }
}