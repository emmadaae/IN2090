# IN2090 Høst 2021
# del 2 i oblig 4 IN2090: programmering med SQL

import psycopg2

# MERK: Må kjøres med Python 3!

# Login details for database user
dbname = "" #Set in your UiO-username
user = "" # Set in your priv-user (UiO-username + _priv)
pwd = "" # Set inn the password for the _priv-user you got in a mail

# Gather all connection info into one string
connection = \
    "host='dbpg-ifi-kurs01.uio.no' " + \
    "dbname='" + dbname + "' " + \
    "user='" + user + "' " + \
    "port='5432' " + \
    "password='" + pwd + "'"

def administrator():
    conn = psycopg2.connect(connection)

    ch = 0
    while (ch != 3):
        print("-- ADMINISTRATOR --")
        print("Please choose an option:\n 1. Create bills\n 2. Insert new product\n 3. Exit")
        ch = get_int_from_user("Option: ", True)

        if (ch == 1):
            make_bills(conn)
        elif (ch == 2):
            insert_product(conn)

def make_bills(conn):
    # Oppg 2
    cursor = conn.cursor()
    name = ("SELECT u.username, u.address, SUM(p.price + o.num) as total_due FROM ws.users u INNER JOIN ws.orders o ON u.uid = o.uid INNER JOIN ws.products p ON o.pid = p.pid WHERE payed = 0 GROUP BY (u.username, u.address) ;")
    cursor.execute(name)
    rows = cursor.fetchall()
    for i in rows:
        print("-- BILL --")
        print("name: " + str(i[0]))
        print("address: " + str(i[1]))
        print("total due: " + str(i[2]))
        print(" ")
        print(" ")


def insert_product(conn):
    # Oppg 3
    cursor = conn.cursor()
    print("-- INSERT PRODUCT --")
    product_name = input("Product name: ")
    price = get_float_from_user("Price: ", True)
    category = input("Category: ")

    # ser om kategori eksisterer
    cursor.execute("SELECT * from ws.categories")
    rows_categories = cursor.fetchall()
    categories = set()
    cid_list = []
    for c in rows_categories:
        categories.add(c[1])
        cid_list.append(c[0])

    # hvis kategori ikke allerede eksisterer legges den inn, og cid lages
    if category not in categories:
        next_int = cid_list[-1] + 1
        cid = next_int
        cursor.execute("INSERT INTO ws.categories(cid, name) VALUES (%s, %s);", (cid, category))
        conn.commit()
    else:
        finn_cid = ("SELECT cid FROM ws.categories WHERE name LIKE " +"'" + str(category) + "'" + ";")
        cursor.execute(finn_cid)
        cid_raw = cursor.fetchall()
        for i in cid_raw:
            cid = i[0]

    description = str(input("Description: "))
    cursor.execute(" INSERT INTO ws.products(name, price, cid, description) VALUES (%s, %s, %s, %s);", (product_name, price, cid, description))
    conn.commit()
    print("New product " + product_name + " inserted. ")

    # printer produkter for å sjekke at det er riktig og satt inn
    cursor.execute("SELECT * FROM ws.products ;")
    rows = cursor.fetchall()
    for i in rows:
        print(i)



def get_int_from_user(msg, needed):
    # Utility method that gets an int from the user with the first argument as message
    # Second argument is boolean, and if false allows user to not give input, and will then
    # return None
    while True:
        numStr = input(msg)
        if (numStr == "" and not needed):
            return None;
        try:
            return int(numStr)
        except:
            print("Please provide an integer or leave blank.");

def get_float_from_user(msg, needed):
    # Utility method that gets a float from the user with the first argument as message
    # Second argument is boolean, and if false allows user to not give input, and will then
    # return None
    while True:
        numStr = input(msg)
        if (numStr == "" and not needed):
            return None;
        try:
            return float(numStr) # endret til float fra int for å kunne sette inn pris i float
        except:
            print("Please provide an integer or leave blank.");

if __name__ == "__main__":
    administrator()
