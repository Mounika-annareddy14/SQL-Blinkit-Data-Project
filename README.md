
<h1>🛒 Blinkit Data Warehouse Project (MS SQL Server) – Bronze Layer</h1>

<h2>📌 Project Overview</h2>
<p>
This project implements a <strong>Data Warehouse pipeline in MS SQL Server</strong> using Blinkit business data stored in CSV files.
Using <strong>Mandelion Architecture</strong>
The current implementation covers the <strong>Bronze Layer</strong>, where raw data from source CSV files is ingested into SQL Server using:
</p>
<ul>
    <li>Batch Processing</li>
    <li>Full Load Strategy</li>
    <li>TRUNCATE and INSERT approach</li>
    <li>BULK INSERT for high-performance loading</li>
</ul>

<h2>🧱 Architecture (Current Stage)</h2>
<pre>CSV Files  →  Bronze Layer (Raw Tables in SQL Server)</pre>

<h2>🛠 Tools & Technologies Used</h2>
<ul>
    <li>Microsoft SQL Server</li>
    <li>SSMS</li>
    <li>BULK INSERT</li>
    <li>Stored Procedures</li>
    <li>Schemas</li>
    <li>Batch Processing</li>
</ul>

<h2>📂 Source Files Loaded</h2>
<ul>
    <li>blinkit_customers.csv</li>
    <li>blinkit_orders.csv</li>
    <li>blinkit_order_items.csv</li>
    <li>blinkit_products.csv</li>
    <li>blinkit_inventoryNew.csv</li>
    <li>blinkit_delivery_performance.csv</li>
    <li>blinkit_marketing_performance.csv</li>
    <li>blinkit_customer_feedback.csv</li>
    <li>Category_Icons.csv</li>
    <li>Rating_Icon.csv</li>
</ul>

<h2>🥉 Bronze Layer Implementation</h2>

<h3>Schema</h3>
<pre><code>CREATE SCHEMA bronze;</code></pre>

<h3>Tables</h3>
<p>All tables are created under the <code>bronze</code> schema with VARCHAR columns to avoid data type issues during raw ingestion.</p>

<h2>⚙️ Loading Strategy Used</h2>
<ol>
    <li>Table is <strong>TRUNCATED</strong></li>
    <li>Data is <strong>reloaded completely</strong> from CSV</li>
    <li>Performed using <strong>BULK INSERT</strong></li>
    <li>Executed via a single stored procedure (Batch Processing)</li>
</ol>

<h2>🧪 BULK INSERT Configuration</h2>
<ul>
    <li><code>FIRSTROW = 2</code> – Skip headers</li>
    <li><code>FIELDTERMINATOR = ','</code></li>
    <li><code>FIELDQUOTE = '"'</code></li>
    <li><code>CODEPAGE = '65001'</code> – UTF-8 support</li>
    <li><code>TABLOCK</code> – Faster loading</li>
</ul>

<h2>▶️ Execution</h2>
<pre><code>EXEC bronze.load_bronze;</code></pre>

<h2>🎯 Purpose of Bronze Layer</h2>
<table>
    <tr>
        <th>Aspect</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>Raw Ingestion</td>
        <td>Exact copy of source data</td>
    </tr>
    <tr>
        <td>Full Load</td>
        <td>Reload entire dataset every run</td>
    </tr>
    <tr>
        <td>Truncate & Insert</td>
        <td>Ensures fresh data each batch</td>
    </tr>
    <tr>
        <td>Batch Processing</td>
        <td>Single procedure handles all loads</td>
    </tr>
    <tr>
        <td>Foundation</td>
        <td>Base layer for Silver transformations</td>
    </tr>
</table>

<h2>✅ Current Status</h2>
<ul>
    <li>Bronze Layer Completed Successfully</li>
    <li>Silver Layer – Pending</li>
    <li>Gold Layer – Pending</li>
</ul>

<h2>👩‍💻 Author</h2>
<p><strong>Mounika Reddy</strong><br>

</body>
</html>



