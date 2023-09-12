using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace B2CAdmin.App_Code
{
    public class ClsSqlConnection
    {
        public string SqlCon= "Data Source=103.48.51.217,1232;Initial Catalog=B2CAdminKundanDb;User ID=sa;Password=ffbj*2hFWn#2sn3@dd";
        public string GetConn()
        {
            return SqlCon;
        }
    }
}