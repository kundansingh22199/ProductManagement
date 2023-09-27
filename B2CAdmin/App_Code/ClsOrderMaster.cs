using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace B2CAdmin.App_Code
{
    public class ClsOrderMaster : ClsSqlConnection
    {
        public int InsertOrder(string OrderId, string StockId, int Quantity, decimal Price, decimal TotalPrice, string PaymentMode, string PaymentReceipt, string OrderBy)
        {
            try
            {
                int result = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderId", OrderId);
                cmd.Parameters.AddWithValue("@StockId", StockId);
                cmd.Parameters.AddWithValue("@Quantity", Quantity);
                cmd.Parameters.AddWithValue("@Price", Price);
                cmd.Parameters.AddWithValue("@TotalPrice", TotalPrice);
                cmd.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                cmd.Parameters.AddWithValue("@PaymentReceipt", PaymentReceipt);
                cmd.Parameters.AddWithValue("@OrderBy", OrderBy);
                con.Open();
                result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public int UpdateOrderStatus(int Id, string Status, string UpdateBy)
        {
            try
            {
                int result = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_UpdateOrderStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.AddWithValue("@UpdateBy", UpdateBy);
                con.Open();
                result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public DataTable GetOrderListByOrderId(string OrderBy)
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetOrderListByUserId", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderBy", OrderBy);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public DataTable GetOrderList()
        {
            try
            {
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_GetOrderList", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public int InsertSallerStock(int StockId, int SallerId, int Quantity, decimal Price)
        {
            try
            {
                int result = 0;
                SqlConnection con = new SqlConnection(SqlCon);
                SqlCommand cmd = new SqlCommand("SP_InsertSellarStock", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StockId", StockId);
                cmd.Parameters.AddWithValue("@SallerId", SallerId);
                cmd.Parameters.AddWithValue("@Quantity", Quantity);
                cmd.Parameters.AddWithValue("@Price", Price);
                con.Open();
                result = cmd.ExecuteNonQuery();
                return result;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}