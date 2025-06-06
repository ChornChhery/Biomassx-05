PGDMP  0                    }            biomassx     17.2 (Ubuntu 17.2-1.pgdg24.04+1)     17.4 (Ubuntu 17.4-1.pgdg24.04+2) z   Q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            R           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            S           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            T           1262    16388    biomassx    DATABASE     t   CREATE DATABASE biomassx WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE biomassx;
                     postgres    false                        2615    19754    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     postgres    false            U           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        postgres    false    5            V           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                        postgres    false    5            �            1259    19755    address_types    TABLE     �   CREATE TABLE public.address_types (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    description character varying(256)
);
 !   DROP TABLE public.address_types;
       public         heap r       postgres    false    5            �            1259    19758    address_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.address_types_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.address_types_id_seq;
       public               postgres    false    217    5            W           0    0    address_types_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.address_types_id_seq OWNED BY public.address_types.id;
          public               postgres    false    218            �            1259    19759 	   addresses    TABLE     8  CREATE TABLE public.addresses (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    address_type_id smallint NOT NULL,
    branch_number character varying(5),
    tax_number character varying(13),
    country_id integer,
    province_id integer,
    district_id integer,
    subdistrict_id integer,
    street character varying(128),
    address character varying(256),
    postal_code character varying(9),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.addresses;
       public         heap r       postgres    false    5            �            1259    19764    addresses_id_seq    SEQUENCE     y   CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.addresses_id_seq;
       public               postgres    false    5    219            X           0    0    addresses_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;
          public               postgres    false    220            �            1259    19765    banks    TABLE     �   CREATE TABLE public.banks (
    id smallint NOT NULL,
    en_name character varying(128),
    th_name character varying(128)
);
    DROP TABLE public.banks;
       public         heap r       postgres    false    5            �            1259    19768    banks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.banks_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.banks_id_seq;
       public               postgres    false    221    5            Y           0    0    banks_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;
          public               postgres    false    222            �            1259    19769 
   categories    TABLE     �   CREATE TABLE public.categories (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.categories;
       public         heap r       postgres    false    5            �            1259    19772    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public               postgres    false    223    5            Z           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public               postgres    false    224            �            1259    19773    contract_types    TABLE     �   CREATE TABLE public.contract_types (
    id integer NOT NULL,
    en_name character varying(50) NOT NULL,
    th_name character varying(50),
    code character varying(8),
    description character varying(100)
);
 "   DROP TABLE public.contract_types;
       public         heap r       postgres    false    5            �            1259    19776    contract_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contract_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.contract_types_id_seq;
       public               postgres    false    225    5            [           0    0    contract_types_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.contract_types_id_seq OWNED BY public.contract_types.id;
          public               postgres    false    226            �            1259    19777 	   contracts    TABLE     s  CREATE TABLE public.contracts (
    id bigint NOT NULL,
    marketspace_id smallint NOT NULL,
    market_id smallint NOT NULL,
    submarket_id smallint NOT NULL,
    contract_date timestamp with time zone NOT NULL,
    contract_type_id smallint NOT NULL,
    seller_matching_id bigint NOT NULL,
    buyer_matching_id bigint NOT NULL,
    product_id smallint NOT NULL,
    quality_id smallint NOT NULL,
    price numeric(9,2) NOT NULL,
    currency_id smallint NOT NULL,
    quantity numeric(9,2) NOT NULL,
    uom_id smallint NOT NULL,
    packing_id smallint NOT NULL,
    delivery_term_id smallint NOT NULL,
    seller_country_id smallint,
    buyer_country_id smallint,
    place_of_delivery_province smallint,
    place_of_delivery_district smallint,
    place_of_delivery_subdistrict smallint,
    seller_port_of_loading_id smallint,
    seller_port_of_discharge_id smallint,
    buyer_port_of_loading_id smallint,
    buyer_port_of_discharge_id smallint,
    delivery_status_id smallint NOT NULL,
    start_delivery_date date NOT NULL,
    finish_delivery_date date NOT NULL,
    payment_term_id smallint NOT NULL,
    payment_status_id smallint NOT NULL,
    seller_remark character varying(256),
    buyer_remark character varying(256),
    seller_confirmation_status_id smallint NOT NULL,
    buyer_confirmation_status_id smallint NOT NULL,
    contract_status_id smallint NOT NULL
);
    DROP TABLE public.contracts;
       public         heap r       postgres    false    5            �            1259    19782    contracts_id_seq    SEQUENCE     y   CREATE SEQUENCE public.contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.contracts_id_seq;
       public               postgres    false    5    227            \           0    0    contracts_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.contracts_id_seq OWNED BY public.contracts.id;
          public               postgres    false    228            �            1259    19783 	   countries    TABLE       CREATE TABLE public.countries (
    id smallint NOT NULL,
    en_name character varying(128),
    th_name character varying(128),
    alpha2 character varying(8),
    alpha3 character varying(8),
    country_code character varying(8),
    iso3166_2 character varying(16),
    region character varying(16),
    sub_region character varying(128),
    intermediate_region character varying(32),
    region_code character varying(8),
    sub_region_code character varying(8),
    intermediate_region_code character varying(8)
);
    DROP TABLE public.countries;
       public         heap r       postgres    false    5            �            1259    19788    countries_currencies    TABLE     z   CREATE TABLE public.countries_currencies (
    id smallint NOT NULL,
    country_id smallint,
    currency_id smallint
);
 (   DROP TABLE public.countries_currencies;
       public         heap r       postgres    false    5            �            1259    19791    countries_currencies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.countries_currencies_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.countries_currencies_id_seq;
       public               postgres    false    5    230            ]           0    0    countries_currencies_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.countries_currencies_id_seq OWNED BY public.countries_currencies.id;
          public               postgres    false    231            �            1259    19792    countries_id_seq    SEQUENCE     �   CREATE SEQUENCE public.countries_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.countries_id_seq;
       public               postgres    false    5    229            ^           0    0    countries_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;
          public               postgres    false    232            �            1259    19793 !   countries_marketspaces_currencies    TABLE     �   CREATE TABLE public.countries_marketspaces_currencies (
    id smallint NOT NULL,
    country_id smallint,
    marketspace_id smallint,
    currency_id smallint
);
 5   DROP TABLE public.countries_marketspaces_currencies;
       public         heap r       postgres    false    5            �            1259    19796 (   countries_marketspaces_currencies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.countries_marketspaces_currencies_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.countries_marketspaces_currencies_id_seq;
       public               postgres    false    233    5            _           0    0 (   countries_marketspaces_currencies_id_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.countries_marketspaces_currencies_id_seq OWNED BY public.countries_marketspaces_currencies.id;
          public               postgres    false    234            �            1259    19797 
   currencies    TABLE     �   CREATE TABLE public.currencies (
    id smallint NOT NULL,
    code character varying(8),
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.currencies;
       public         heap r       postgres    false    5            �            1259    19800    currencies_currency_id_seq    SEQUENCE     �   CREATE SEQUENCE public.currencies_currency_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.currencies_currency_id_seq;
       public               postgres    false    235    5            `           0    0    currencies_currency_id_seq    SEQUENCE OWNED BY     P   ALTER SEQUENCE public.currencies_currency_id_seq OWNED BY public.currencies.id;
          public               postgres    false    236            �            1259    19801    currencies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.currencies_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.currencies_id_seq;
       public               postgres    false    5    235            a           0    0    currencies_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.currencies_id_seq OWNED BY public.currencies.id;
          public               postgres    false    237            �            1259    19802    currency_rates    TABLE     �   CREATE TABLE public.currency_rates (
    id smallint NOT NULL,
    currency_id smallint,
    base_currency_id smallint,
    rate numeric(16,6),
    created_at timestamp with time zone
);
 "   DROP TABLE public.currency_rates;
       public         heap r       postgres    false    5            �            1259    19805    currency_rates_id_seq    SEQUENCE     �   CREATE SEQUENCE public.currency_rates_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.currency_rates_id_seq;
       public               postgres    false    238    5            b           0    0    currency_rates_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.currency_rates_id_seq OWNED BY public.currency_rates.id;
          public               postgres    false    239            �            1259    19806    delivery_terms    TABLE     �   CREATE TABLE public.delivery_terms (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64),
    description character varying(255)
);
 "   DROP TABLE public.delivery_terms;
       public         heap r       postgres    false    5            �            1259    19809    delivery_terms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.delivery_terms_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.delivery_terms_id_seq;
       public               postgres    false    240    5            c           0    0    delivery_terms_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.delivery_terms_id_seq OWNED BY public.delivery_terms.id;
          public               postgres    false    241            �            1259    19810    delivery_terms_marketspaces    TABLE     �   CREATE TABLE public.delivery_terms_marketspaces (
    id smallint NOT NULL,
    delivery_term_id integer,
    marketspace_id integer
);
 /   DROP TABLE public.delivery_terms_marketspaces;
       public         heap r       postgres    false    5            �            1259    19813 "   delivery_terms_marketspaces_id_seq    SEQUENCE     �   CREATE SEQUENCE public.delivery_terms_marketspaces_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.delivery_terms_marketspaces_id_seq;
       public               postgres    false    5    242            d           0    0 "   delivery_terms_marketspaces_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.delivery_terms_marketspaces_id_seq OWNED BY public.delivery_terms_marketspaces.id;
          public               postgres    false    243            �            1259    19814    departments    TABLE     j   CREATE TABLE public.departments (
    id integer NOT NULL,
    en_name character varying(100) NOT NULL
);
    DROP TABLE public.departments;
       public         heap r       postgres    false    5            �            1259    19817    departments_department_id_seq    SEQUENCE     �   CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.departments_department_id_seq;
       public               postgres    false    244    5            e           0    0    departments_department_id_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments.id;
          public               postgres    false    245            �            1259    19818 	   districts    TABLE     �   CREATE TABLE public.districts (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64) NOT NULL,
    province_id smallint NOT NULL,
    country_id smallint NOT NULL
);
    DROP TABLE public.districts;
       public         heap r       postgres    false    5            �            1259    19821    districts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.districts_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.districts_id_seq;
       public               postgres    false    246    5            f           0    0    districts_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.districts_id_seq OWNED BY public.districts.id;
          public               postgres    false    247            �            1259    19822 	   employees    TABLE     �   CREATE TABLE public.employees (
    id integer NOT NULL,
    en_name character varying(100) NOT NULL,
    department_id integer
);
    DROP TABLE public.employees;
       public         heap r       postgres    false    5            �            1259    19825    employees_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.employees_employee_id_seq;
       public               postgres    false    248    5            g           0    0    employees_employee_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.id;
          public               postgres    false    249            �            1259    19826    grades    TABLE     �   CREATE TABLE public.grades (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64)
);
    DROP TABLE public.grades;
       public         heap r       postgres    false    5            �            1259    19829    grades_id_seq    SEQUENCE     �   CREATE SEQUENCE public.grades_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.grades_id_seq;
       public               postgres    false    5    250            h           0    0    grades_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;
          public               postgres    false    251            �            1259    19830    marketplaces    TABLE     �   CREATE TABLE public.marketplaces (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64) NOT NULL
);
     DROP TABLE public.marketplaces;
       public         heap r       postgres    false    5            �            1259    19833    marketplaces_id_seq    SEQUENCE     �   CREATE SEQUENCE public.marketplaces_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.marketplaces_id_seq;
       public               postgres    false    5    252            i           0    0    marketplaces_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.marketplaces_id_seq OWNED BY public.marketplaces.id;
          public               postgres    false    253            �            1259    19834    markets    TABLE     �   CREATE TABLE public.markets (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64)
);
    DROP TABLE public.markets;
       public         heap r       postgres    false    5            �            1259    19837    markets_id_seq    SEQUENCE     �   CREATE SEQUENCE public.markets_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.markets_id_seq;
       public               postgres    false    254    5            j           0    0    markets_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.markets_id_seq OWNED BY public.markets.id;
          public               postgres    false    255                        1259    19838    marketspaces    TABLE     �   CREATE TABLE public.marketspaces (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64)
);
     DROP TABLE public.marketspaces;
       public         heap r       postgres    false    5                       1259    19841    marketspaces_id_seq    SEQUENCE     �   CREATE SEQUENCE public.marketspaces_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.marketspaces_id_seq;
       public               postgres    false    256    5            k           0    0    marketspaces_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.marketspaces_id_seq OWNED BY public.marketspaces.id;
          public               postgres    false    257                       1259    19842    matching_types    TABLE     �   CREATE TABLE public.matching_types (
    id integer NOT NULL,
    en_name character varying(32) NOT NULL,
    th_name character varying(50),
    code character varying(8),
    description character varying(100)
);
 "   DROP TABLE public.matching_types;
       public         heap r       postgres    false    5                       1259    19845    matching_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.matching_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.matching_types_id_seq;
       public               postgres    false    258    5            l           0    0    matching_types_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.matching_types_id_seq OWNED BY public.matching_types.id;
          public               postgres    false    259                       1259    19846 	   matchings    TABLE     A  CREATE TABLE public.matchings (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    marketspace_id smallint NOT NULL,
    market_id smallint NOT NULL,
    submarket_id smallint NOT NULL,
    order_type_id smallint NOT NULL,
    matching_type_id smallint NOT NULL,
    contract_type_id smallint NOT NULL,
    product_id smallint NOT NULL,
    quality_id smallint NOT NULL,
    price numeric(9,2) NOT NULL,
    currency_id smallint NOT NULL,
    quantity numeric(9,2) NOT NULL,
    uom_id smallint NOT NULL,
    packing_id smallint NOT NULL,
    payment_term_id smallint NOT NULL,
    delivery_term_id smallint NOT NULL,
    country_id smallint NOT NULL,
    port_of_loading_id smallint,
    port_of_discharge_id smallint,
    province_id smallint,
    district_id smallint,
    subdistrict_id smallint,
    first_delivery_date date NOT NULL,
    last_delivery_date date NOT NULL,
    remark character varying(128),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status_id smallint
);
    DROP TABLE public.matchings;
       public         heap r       postgres    false    5                       1259    19851    matchings_id_seq    SEQUENCE     y   CREATE SEQUENCE public.matchings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.matchings_id_seq;
       public               postgres    false    5    260            m           0    0    matchings_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.matchings_id_seq OWNED BY public.matchings.id;
          public               postgres    false    261                       1259    19852    order_types    TABLE     �   CREATE TABLE public.order_types (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.order_types;
       public         heap r       postgres    false    5                       1259    19855    order_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_type_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.order_type_id_seq;
       public               postgres    false    262    5            n           0    0    order_type_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.order_type_id_seq OWNED BY public.order_types.id;
          public               postgres    false    263                       1259    19856    order_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_types_id_seq;
       public               postgres    false    262    5            o           0    0    order_types_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_types_id_seq OWNED BY public.order_types.id;
          public               postgres    false    264            	           1259    19857    orders    TABLE     >  CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    marketspace_id smallint NOT NULL,
    market_id smallint NOT NULL,
    submarket_id smallint NOT NULL,
    order_type_id smallint NOT NULL,
    matching_type_id smallint NOT NULL,
    contract_type_id smallint NOT NULL,
    product_id smallint NOT NULL,
    quality_id smallint NOT NULL,
    price numeric(9,2) NOT NULL,
    currency_id smallint NOT NULL,
    quantity numeric(9,2) NOT NULL,
    uom_id smallint NOT NULL,
    packing_id smallint NOT NULL,
    payment_term_id smallint NOT NULL,
    delivery_term_id smallint NOT NULL,
    country_id smallint NOT NULL,
    port_of_loading_id smallint,
    port_of_discharge_id smallint,
    province_id smallint,
    district_id smallint,
    subdistrict_id smallint,
    first_delivery_date date NOT NULL,
    last_delivery_date date NOT NULL,
    remark character varying(128),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status_id smallint
);
    DROP TABLE public.orders;
       public         heap r       postgres    false    5            
           1259    19862    orders_id_seq    SEQUENCE     v   CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public               postgres    false    265    5            p           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public               postgres    false    266                       1259    19863    packings    TABLE     �   CREATE TABLE public.packings (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.packings;
       public         heap r       postgres    false    5                       1259    19866    packings_id_seq    SEQUENCE     �   CREATE SEQUENCE public.packings_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.packings_id_seq;
       public               postgres    false    5    267            q           0    0    packings_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.packings_id_seq OWNED BY public.packings.id;
          public               postgres    false    268                       1259    19867    payment_terms    TABLE     �   CREATE TABLE public.payment_terms (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64),
    description character varying(255)
);
 !   DROP TABLE public.payment_terms;
       public         heap r       postgres    false    5                       1259    19870    payment_terms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_terms_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.payment_terms_id_seq;
       public               postgres    false    5    269            r           0    0    payment_terms_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.payment_terms_id_seq OWNED BY public.payment_terms.id;
          public               postgres    false    270                       1259    19871    payment_terms_marketspaces    TABLE     �   CREATE TABLE public.payment_terms_marketspaces (
    id smallint NOT NULL,
    payment_term_id integer,
    marketspace_id integer
);
 .   DROP TABLE public.payment_terms_marketspaces;
       public         heap r       postgres    false    5                       1259    19874 !   payment_terms_marketspaces_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_terms_marketspaces_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.payment_terms_marketspaces_id_seq;
       public               postgres    false    271    5            s           0    0 !   payment_terms_marketspaces_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.payment_terms_marketspaces_id_seq OWNED BY public.payment_terms_marketspaces.id;
          public               postgres    false    272                       1259    19875    ports    TABLE     �   CREATE TABLE public.ports (
    id smallint NOT NULL,
    en_name character varying(128),
    th_name character varying(128),
    country_id smallint
);
    DROP TABLE public.ports;
       public         heap r       postgres    false    5                       1259    19878    ports_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ports_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.ports_id_seq;
       public               postgres    false    5    273            t           0    0    ports_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.ports_id_seq OWNED BY public.ports.id;
          public               postgres    false    274                       1259    19879    product_categories    TABLE     �   CREATE TABLE public.product_categories (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
 &   DROP TABLE public.product_categories;
       public         heap r       postgres    false    5                       1259    19882    product_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.product_categories_id_seq;
       public               postgres    false    5    275            u           0    0    product_categories_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;
          public               postgres    false    276                       1259    19883    product_subcategories    TABLE     �   CREATE TABLE public.product_subcategories (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    product_category_id integer
);
 )   DROP TABLE public.product_subcategories;
       public         heap r       postgres    false    5                       1259    19886    product_subcategories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_subcategories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.product_subcategories_id_seq;
       public               postgres    false    277    5            v           0    0    product_subcategories_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.product_subcategories_id_seq OWNED BY public.product_subcategories.id;
          public               postgres    false    278                       1259    19887    products    TABLE       CREATE TABLE public.products (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    product_category_id smallint,
    product_subcategory_id smallint,
    market_id smallint,
    submarket_id smallint
);
    DROP TABLE public.products;
       public         heap r       postgres    false    5                       1259    19890    products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public               postgres    false    279    5            w           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public               postgres    false    280                       1259    19891 
   promotions    TABLE     �   CREATE TABLE public.promotions (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.promotions;
       public         heap r       postgres    false    5                       1259    19894    promotions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.promotions_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.promotions_id_seq;
       public               postgres    false    281    5            x           0    0    promotions_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.promotions_id_seq OWNED BY public.promotions.id;
          public               postgres    false    282                       1259    19895 	   provinces    TABLE     �   CREATE TABLE public.provinces (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64) NOT NULL,
    region_id smallint,
    country_id smallint
);
    DROP TABLE public.provinces;
       public         heap r       postgres    false    5                       1259    19898    provinces_id_seq    SEQUENCE     �   CREATE SEQUENCE public.provinces_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.provinces_id_seq;
       public               postgres    false    5    283            y           0    0    provinces_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.provinces_id_seq OWNED BY public.provinces.id;
          public               postgres    false    284                       1259    19899 	   qualities    TABLE     �   CREATE TABLE public.qualities (
    id smallint NOT NULL,
    product_id smallint NOT NULL,
    standard_id smallint NOT NULL,
    grade_id smallint NOT NULL
);
    DROP TABLE public.qualities;
       public         heap r       postgres    false    5                       1259    19902    qualities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.qualities_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.qualities_id_seq;
       public               postgres    false    5    285            z           0    0    qualities_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.qualities_id_seq OWNED BY public.qualities.id;
          public               postgres    false    286                       1259    19903    regions    TABLE     �   CREATE TABLE public.regions (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64) NOT NULL,
    country_id integer
);
    DROP TABLE public.regions;
       public         heap r       postgres    false    5                        1259    19906    regions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.regions_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.regions_id_seq;
       public               postgres    false    5    287            {           0    0    regions_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.regions_id_seq OWNED BY public.regions.id;
          public               postgres    false    288            !           1259    19907    segments    TABLE     �   CREATE TABLE public.segments (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
    DROP TABLE public.segments;
       public         heap r       postgres    false    5            "           1259    19910    segments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.segments_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.segments_id_seq;
       public               postgres    false    289    5            |           0    0    segments_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.segments_id_seq OWNED BY public.segments.id;
          public               postgres    false    290            #           1259    19911    service_categories    TABLE     �   CREATE TABLE public.service_categories (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
 &   DROP TABLE public.service_categories;
       public         heap r       postgres    false    5            $           1259    19914    service_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.service_categories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.service_categories_id_seq;
       public               postgres    false    291    5            }           0    0    service_categories_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.service_categories_id_seq OWNED BY public.service_categories.id;
          public               postgres    false    292            %           1259    19915    service_subcategories    TABLE     �   CREATE TABLE public.service_subcategories (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    service_category_id integer
);
 )   DROP TABLE public.service_subcategories;
       public         heap r       postgres    false    5            &           1259    19918    service_subcategories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.service_subcategories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.service_subcategories_id_seq;
       public               postgres    false    5    293            ~           0    0    service_subcategories_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.service_subcategories_id_seq OWNED BY public.service_subcategories.id;
          public               postgres    false    294            '           1259    19919 	   standards    TABLE     �   CREATE TABLE public.standards (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    product_category_id smallint,
    product_subcategory_id smallint,
    description character varying(255)
);
    DROP TABLE public.standards;
       public         heap r       postgres    false    5            (           1259    19922    standards_id_seq    SEQUENCE     �   CREATE SEQUENCE public.standards_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.standards_id_seq;
       public               postgres    false    5    295                       0    0    standards_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.standards_id_seq OWNED BY public.standards.id;
          public               postgres    false    296            )           1259    19923    status_categories    TABLE     �   CREATE TABLE public.status_categories (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
 %   DROP TABLE public.status_categories;
       public         heap r       postgres    false    5            *           1259    19926    status_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_categories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.status_categories_id_seq;
       public               postgres    false    297    5            �           0    0    status_categories_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.status_categories_id_seq OWNED BY public.status_categories.id;
          public               postgres    false    298            +           1259    19927    status_categories_statuses    TABLE     �   CREATE TABLE public.status_categories_statuses (
    id smallint NOT NULL,
    status_category_id integer,
    status_id integer,
    description character varying
);
 .   DROP TABLE public.status_categories_statuses;
       public         heap r       postgres    false    5            ,           1259    19932 !   status_categories_statuses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_categories_statuses_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.status_categories_statuses_id_seq;
       public               postgres    false    299    5            �           0    0 !   status_categories_statuses_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.status_categories_statuses_id_seq OWNED BY public.status_categories_statuses.id;
          public               postgres    false    300            -           1259    19933    statuses    TABLE     �   CREATE TABLE public.statuses (
    id smallint NOT NULL,
    en_name character varying NOT NULL,
    th_name character varying NOT NULL
);
    DROP TABLE public.statuses;
       public         heap r       postgres    false    5            .           1259    19938    statuses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.statuses_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.statuses_id_seq;
       public               postgres    false    5    301            �           0    0    statuses_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.statuses_id_seq OWNED BY public.statuses.id;
          public               postgres    false    302            /           1259    19939    subcategories    TABLE     �   CREATE TABLE public.subcategories (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64)
);
 !   DROP TABLE public.subcategories;
       public         heap r       postgres    false    5            0           1259    19942    subcategories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subcategories_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.subcategories_id_seq;
       public               postgres    false    303    5            �           0    0    subcategories_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.subcategories_id_seq OWNED BY public.subcategories.id;
          public               postgres    false    304            1           1259    19943    subdistricts    TABLE     �   CREATE TABLE public.subdistricts (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64) NOT NULL,
    district_id smallint,
    postal_code character varying(16)
);
     DROP TABLE public.subdistricts;
       public         heap r       postgres    false    5            2           1259    19946    subdistricts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subdistricts_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.subdistricts_id_seq;
       public               postgres    false    5    305            �           0    0    subdistricts_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.subdistricts_id_seq OWNED BY public.subdistricts.id;
          public               postgres    false    306            3           1259    19947 
   submarkets    TABLE     �   CREATE TABLE public.submarkets (
    id smallint NOT NULL,
    en_name character varying(64) NOT NULL,
    th_name character varying(64),
    market_id smallint
);
    DROP TABLE public.submarkets;
       public         heap r       postgres    false    5            4           1259    19950    submarkets_id_seq    SEQUENCE     �   CREATE SEQUENCE public.submarkets_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.submarkets_id_seq;
       public               postgres    false    5    307            �           0    0    submarkets_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.submarkets_id_seq OWNED BY public.submarkets.id;
          public               postgres    false    308            5           1259    19951    subsegments    TABLE     �   CREATE TABLE public.subsegments (
    id smallint NOT NULL,
    en_name character varying(64),
    th_name character varying(64),
    segment_id smallint
);
    DROP TABLE public.subsegments;
       public         heap r       postgres    false    5            6           1259    19954    subsegments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subsegments_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.subsegments_id_seq;
       public               postgres    false    309    5            �           0    0    subsegments_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.subsegments_id_seq OWNED BY public.subsegments.id;
          public               postgres    false    310            7           1259    19955    uoms    TABLE     �   CREATE TABLE public.uoms (
    id smallint NOT NULL,
    en_name character varying(32),
    th_name character varying(32),
    description character varying(128)
);
    DROP TABLE public.uoms;
       public         heap r       postgres    false    5            8           1259    19958    uoms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.uoms_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.uoms_id_seq;
       public               postgres    false    5    311            �           0    0    uoms_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.uoms_id_seq OWNED BY public.uoms.id;
          public               postgres    false    312            9           1259    19959    users    TABLE     �  CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying(128) NOT NULL,
    last_name character varying(128) NOT NULL,
    organization_name character varying(128),
    username character varying(64) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    phone character varying(15) NOT NULL,
    email character varying(128) NOT NULL,
    confirmation_code character varying(20),
    identification_number character varying(24),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    account_balance numeric(15,2),
    employee_id smallint,
    status_id smallint
);
    DROP TABLE public.users;
       public         heap r       postgres    false    5            :           1259    19966    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    313    5            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    314            ;           1259    19967    users_segments_subsegments    TABLE     �   CREATE TABLE public.users_segments_subsegments (
    id bigint NOT NULL,
    user_id integer,
    segment_id integer,
    subsegment_id integer
);
 .   DROP TABLE public.users_segments_subsegments;
       public         heap r       postgres    false    5            <           1259    19970 !   users_segments_subsegments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_segments_subsegments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.users_segments_subsegments_id_seq;
       public               postgres    false    5    315            �           0    0 !   users_segments_subsegments_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.users_segments_subsegments_id_seq OWNED BY public.users_segments_subsegments.id;
          public               postgres    false    316            �           2604    19971    address_types id    DEFAULT     t   ALTER TABLE ONLY public.address_types ALTER COLUMN id SET DEFAULT nextval('public.address_types_id_seq'::regclass);
 ?   ALTER TABLE public.address_types ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            �           2604    19972    addresses id    DEFAULT     l   ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);
 ;   ALTER TABLE public.addresses ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            �           2604    19973    banks id    DEFAULT     d   ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);
 7   ALTER TABLE public.banks ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            �           2604    19974    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            �           2604    19975    contract_types id    DEFAULT     v   ALTER TABLE ONLY public.contract_types ALTER COLUMN id SET DEFAULT nextval('public.contract_types_id_seq'::regclass);
 @   ALTER TABLE public.contract_types ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            �           2604    19976    contracts id    DEFAULT     l   ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);
 ;   ALTER TABLE public.contracts ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227            �           2604    19977    countries id    DEFAULT     l   ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);
 ;   ALTER TABLE public.countries ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    232    229            �           2604    19978    countries_currencies id    DEFAULT     �   ALTER TABLE ONLY public.countries_currencies ALTER COLUMN id SET DEFAULT nextval('public.countries_currencies_id_seq'::regclass);
 F   ALTER TABLE public.countries_currencies ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    230            �           2604    19979 $   countries_marketspaces_currencies id    DEFAULT     �   ALTER TABLE ONLY public.countries_marketspaces_currencies ALTER COLUMN id SET DEFAULT nextval('public.countries_marketspaces_currencies_id_seq'::regclass);
 S   ALTER TABLE public.countries_marketspaces_currencies ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    234    233            �           2604    19980    currencies id    DEFAULT     n   ALTER TABLE ONLY public.currencies ALTER COLUMN id SET DEFAULT nextval('public.currencies_id_seq'::regclass);
 <   ALTER TABLE public.currencies ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    237    235            �           2604    19981    currency_rates id    DEFAULT     v   ALTER TABLE ONLY public.currency_rates ALTER COLUMN id SET DEFAULT nextval('public.currency_rates_id_seq'::regclass);
 @   ALTER TABLE public.currency_rates ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    239    238            �           2604    19982    delivery_terms id    DEFAULT     v   ALTER TABLE ONLY public.delivery_terms ALTER COLUMN id SET DEFAULT nextval('public.delivery_terms_id_seq'::regclass);
 @   ALTER TABLE public.delivery_terms ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    241    240            �           2604    19983    delivery_terms_marketspaces id    DEFAULT     �   ALTER TABLE ONLY public.delivery_terms_marketspaces ALTER COLUMN id SET DEFAULT nextval('public.delivery_terms_marketspaces_id_seq'::regclass);
 M   ALTER TABLE public.delivery_terms_marketspaces ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    243    242            �           2604    19984    departments id    DEFAULT     {   ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);
 =   ALTER TABLE public.departments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    245    244            �           2604    19985    districts id    DEFAULT     l   ALTER TABLE ONLY public.districts ALTER COLUMN id SET DEFAULT nextval('public.districts_id_seq'::regclass);
 ;   ALTER TABLE public.districts ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    247    246            �           2604    19986    employees id    DEFAULT     u   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    249    248            �           2604    19987 	   grades id    DEFAULT     f   ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);
 8   ALTER TABLE public.grades ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    251    250            �           2604    19988    marketplaces id    DEFAULT     r   ALTER TABLE ONLY public.marketplaces ALTER COLUMN id SET DEFAULT nextval('public.marketplaces_id_seq'::regclass);
 >   ALTER TABLE public.marketplaces ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    253    252            �           2604    19989 
   markets id    DEFAULT     h   ALTER TABLE ONLY public.markets ALTER COLUMN id SET DEFAULT nextval('public.markets_id_seq'::regclass);
 9   ALTER TABLE public.markets ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    255    254            �           2604    19990    marketspaces id    DEFAULT     r   ALTER TABLE ONLY public.marketspaces ALTER COLUMN id SET DEFAULT nextval('public.marketspaces_id_seq'::regclass);
 >   ALTER TABLE public.marketspaces ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    257    256            �           2604    19991    matching_types id    DEFAULT     v   ALTER TABLE ONLY public.matching_types ALTER COLUMN id SET DEFAULT nextval('public.matching_types_id_seq'::regclass);
 @   ALTER TABLE public.matching_types ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    259    258            �           2604    19992    matchings id    DEFAULT     l   ALTER TABLE ONLY public.matchings ALTER COLUMN id SET DEFAULT nextval('public.matchings_id_seq'::regclass);
 ;   ALTER TABLE public.matchings ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    261    260            �           2604    19993    order_types id    DEFAULT     p   ALTER TABLE ONLY public.order_types ALTER COLUMN id SET DEFAULT nextval('public.order_types_id_seq'::regclass);
 =   ALTER TABLE public.order_types ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    264    262            �           2604    19994 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    266    265            �           2604    19995    packings id    DEFAULT     j   ALTER TABLE ONLY public.packings ALTER COLUMN id SET DEFAULT nextval('public.packings_id_seq'::regclass);
 :   ALTER TABLE public.packings ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    268    267            �           2604    19996    payment_terms id    DEFAULT     t   ALTER TABLE ONLY public.payment_terms ALTER COLUMN id SET DEFAULT nextval('public.payment_terms_id_seq'::regclass);
 ?   ALTER TABLE public.payment_terms ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    270    269            �           2604    19997    payment_terms_marketspaces id    DEFAULT     �   ALTER TABLE ONLY public.payment_terms_marketspaces ALTER COLUMN id SET DEFAULT nextval('public.payment_terms_marketspaces_id_seq'::regclass);
 L   ALTER TABLE public.payment_terms_marketspaces ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    272    271            �           2604    19998    ports id    DEFAULT     d   ALTER TABLE ONLY public.ports ALTER COLUMN id SET DEFAULT nextval('public.ports_id_seq'::regclass);
 7   ALTER TABLE public.ports ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    274    273            �           2604    19999    product_categories id    DEFAULT     ~   ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);
 D   ALTER TABLE public.product_categories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    276    275            �           2604    20000    product_subcategories id    DEFAULT     �   ALTER TABLE ONLY public.product_subcategories ALTER COLUMN id SET DEFAULT nextval('public.product_subcategories_id_seq'::regclass);
 G   ALTER TABLE public.product_subcategories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    278    277            �           2604    20001    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    280    279            �           2604    20002    promotions id    DEFAULT     n   ALTER TABLE ONLY public.promotions ALTER COLUMN id SET DEFAULT nextval('public.promotions_id_seq'::regclass);
 <   ALTER TABLE public.promotions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    282    281            �           2604    20003    provinces id    DEFAULT     l   ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);
 ;   ALTER TABLE public.provinces ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    284    283            �           2604    20004    qualities id    DEFAULT     l   ALTER TABLE ONLY public.qualities ALTER COLUMN id SET DEFAULT nextval('public.qualities_id_seq'::regclass);
 ;   ALTER TABLE public.qualities ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    286    285            �           2604    20005 
   regions id    DEFAULT     h   ALTER TABLE ONLY public.regions ALTER COLUMN id SET DEFAULT nextval('public.regions_id_seq'::regclass);
 9   ALTER TABLE public.regions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    288    287            �           2604    20006    segments id    DEFAULT     j   ALTER TABLE ONLY public.segments ALTER COLUMN id SET DEFAULT nextval('public.segments_id_seq'::regclass);
 :   ALTER TABLE public.segments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    290    289            �           2604    20007    service_categories id    DEFAULT     ~   ALTER TABLE ONLY public.service_categories ALTER COLUMN id SET DEFAULT nextval('public.service_categories_id_seq'::regclass);
 D   ALTER TABLE public.service_categories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    292    291            �           2604    20008    service_subcategories id    DEFAULT     �   ALTER TABLE ONLY public.service_subcategories ALTER COLUMN id SET DEFAULT nextval('public.service_subcategories_id_seq'::regclass);
 G   ALTER TABLE public.service_subcategories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    294    293            �           2604    20009    standards id    DEFAULT     l   ALTER TABLE ONLY public.standards ALTER COLUMN id SET DEFAULT nextval('public.standards_id_seq'::regclass);
 ;   ALTER TABLE public.standards ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    296    295            �           2604    20010    status_categories id    DEFAULT     |   ALTER TABLE ONLY public.status_categories ALTER COLUMN id SET DEFAULT nextval('public.status_categories_id_seq'::regclass);
 C   ALTER TABLE public.status_categories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    298    297            �           2604    20011    status_categories_statuses id    DEFAULT     �   ALTER TABLE ONLY public.status_categories_statuses ALTER COLUMN id SET DEFAULT nextval('public.status_categories_statuses_id_seq'::regclass);
 L   ALTER TABLE public.status_categories_statuses ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    300    299            �           2604    20012    statuses id    DEFAULT     j   ALTER TABLE ONLY public.statuses ALTER COLUMN id SET DEFAULT nextval('public.statuses_id_seq'::regclass);
 :   ALTER TABLE public.statuses ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    302    301            �           2604    20013    subcategories id    DEFAULT     t   ALTER TABLE ONLY public.subcategories ALTER COLUMN id SET DEFAULT nextval('public.subcategories_id_seq'::regclass);
 ?   ALTER TABLE public.subcategories ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    304    303            �           2604    20014    subdistricts id    DEFAULT     r   ALTER TABLE ONLY public.subdistricts ALTER COLUMN id SET DEFAULT nextval('public.subdistricts_id_seq'::regclass);
 >   ALTER TABLE public.subdistricts ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    306    305            �           2604    20015    submarkets id    DEFAULT     n   ALTER TABLE ONLY public.submarkets ALTER COLUMN id SET DEFAULT nextval('public.submarkets_id_seq'::regclass);
 <   ALTER TABLE public.submarkets ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    308    307            �           2604    20016    subsegments id    DEFAULT     p   ALTER TABLE ONLY public.subsegments ALTER COLUMN id SET DEFAULT nextval('public.subsegments_id_seq'::regclass);
 =   ALTER TABLE public.subsegments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    310    309            �           2604    20017    uoms id    DEFAULT     b   ALTER TABLE ONLY public.uoms ALTER COLUMN id SET DEFAULT nextval('public.uoms_id_seq'::regclass);
 6   ALTER TABLE public.uoms ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    312    311            �           2604    20018    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    314    313            �           2604    20019    users_segments_subsegments id    DEFAULT     �   ALTER TABLE ONLY public.users_segments_subsegments ALTER COLUMN id SET DEFAULT nextval('public.users_segments_subsegments_id_seq'::regclass);
 L   ALTER TABLE public.users_segments_subsegments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    316    315            �          0    19755    address_types 
   TABLE DATA           J   COPY public.address_types (id, en_name, th_name, description) FROM stdin;
    public               postgres    false    217   U�      �          0    19759 	   addresses 
   TABLE DATA           �   COPY public.addresses (id, user_id, address_type_id, branch_number, tax_number, country_id, province_id, district_id, subdistrict_id, street, address, postal_code, created_at, updated_at) FROM stdin;
    public               postgres    false    219   ��      �          0    19765    banks 
   TABLE DATA           5   COPY public.banks (id, en_name, th_name) FROM stdin;
    public               postgres    false    221   ��      �          0    19769 
   categories 
   TABLE DATA           :   COPY public.categories (id, en_name, th_name) FROM stdin;
    public               postgres    false    223   ��      �          0    19773    contract_types 
   TABLE DATA           Q   COPY public.contract_types (id, en_name, th_name, code, description) FROM stdin;
    public               postgres    false    225   c�      �          0    19777 	   contracts 
   TABLE DATA           �  COPY public.contracts (id, marketspace_id, market_id, submarket_id, contract_date, contract_type_id, seller_matching_id, buyer_matching_id, product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, delivery_term_id, seller_country_id, buyer_country_id, place_of_delivery_province, place_of_delivery_district, place_of_delivery_subdistrict, seller_port_of_loading_id, seller_port_of_discharge_id, buyer_port_of_loading_id, buyer_port_of_discharge_id, delivery_status_id, start_delivery_date, finish_delivery_date, payment_term_id, payment_status_id, seller_remark, buyer_remark, seller_confirmation_status_id, buyer_confirmation_status_id, contract_status_id) FROM stdin;
    public               postgres    false    227   ��      �          0    19783 	   countries 
   TABLE DATA           �   COPY public.countries (id, en_name, th_name, alpha2, alpha3, country_code, iso3166_2, region, sub_region, intermediate_region, region_code, sub_region_code, intermediate_region_code) FROM stdin;
    public               postgres    false    229   ��      �          0    19788    countries_currencies 
   TABLE DATA           K   COPY public.countries_currencies (id, country_id, currency_id) FROM stdin;
    public               postgres    false    230   ��      �          0    19793 !   countries_marketspaces_currencies 
   TABLE DATA           h   COPY public.countries_marketspaces_currencies (id, country_id, marketspace_id, currency_id) FROM stdin;
    public               postgres    false    233   ��      �          0    19797 
   currencies 
   TABLE DATA           @   COPY public.currencies (id, code, en_name, th_name) FROM stdin;
    public               postgres    false    235   �                 0    19802    currency_rates 
   TABLE DATA           ]   COPY public.currency_rates (id, currency_id, base_currency_id, rate, created_at) FROM stdin;
    public               postgres    false    238   Z�                0    19806    delivery_terms 
   TABLE DATA           K   COPY public.delivery_terms (id, en_name, th_name, description) FROM stdin;
    public               postgres    false    240   w�                0    19810    delivery_terms_marketspaces 
   TABLE DATA           [   COPY public.delivery_terms_marketspaces (id, delivery_term_id, marketspace_id) FROM stdin;
    public               postgres    false    242   ��                0    19814    departments 
   TABLE DATA           2   COPY public.departments (id, en_name) FROM stdin;
    public               postgres    false    244   �                0    19818 	   districts 
   TABLE DATA           R   COPY public.districts (id, en_name, th_name, province_id, country_id) FROM stdin;
    public               postgres    false    246   5�      
          0    19822 	   employees 
   TABLE DATA           ?   COPY public.employees (id, en_name, department_id) FROM stdin;
    public               postgres    false    248   �#                0    19826    grades 
   TABLE DATA           6   COPY public.grades (id, en_name, th_name) FROM stdin;
    public               postgres    false    250   �#                0    19830    marketplaces 
   TABLE DATA           <   COPY public.marketplaces (id, en_name, th_name) FROM stdin;
    public               postgres    false    252   �$                0    19834    markets 
   TABLE DATA           7   COPY public.markets (id, en_name, th_name) FROM stdin;
    public               postgres    false    254   c%                0    19838    marketspaces 
   TABLE DATA           <   COPY public.marketspaces (id, en_name, th_name) FROM stdin;
    public               postgres    false    256   �%                0    19842    matching_types 
   TABLE DATA           Q   COPY public.matching_types (id, en_name, th_name, code, description) FROM stdin;
    public               postgres    false    258   �&                0    19846 	   matchings 
   TABLE DATA           �  COPY public.matchings (id, user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id, contract_type_id, product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, payment_term_id, delivery_term_id, country_id, port_of_loading_id, port_of_discharge_id, province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date, remark, created_at, updated_at, status_id) FROM stdin;
    public               postgres    false    260   \'                0    19852    order_types 
   TABLE DATA           ;   COPY public.order_types (id, en_name, th_name) FROM stdin;
    public               postgres    false    262   (                0    19857    orders 
   TABLE DATA           �  COPY public.orders (id, user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id, contract_type_id, product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, payment_term_id, delivery_term_id, country_id, port_of_loading_id, port_of_discharge_id, province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date, remark, created_at, updated_at, status_id) FROM stdin;
    public               postgres    false    265   S(                0    19863    packings 
   TABLE DATA           8   COPY public.packings (id, en_name, th_name) FROM stdin;
    public               postgres    false    267   )                0    19867    payment_terms 
   TABLE DATA           J   COPY public.payment_terms (id, en_name, th_name, description) FROM stdin;
    public               postgres    false    269   �)      !          0    19871    payment_terms_marketspaces 
   TABLE DATA           Y   COPY public.payment_terms_marketspaces (id, payment_term_id, marketspace_id) FROM stdin;
    public               postgres    false    271   l*      #          0    19875    ports 
   TABLE DATA           A   COPY public.ports (id, en_name, th_name, country_id) FROM stdin;
    public               postgres    false    273   �*      %          0    19879    product_categories 
   TABLE DATA           B   COPY public.product_categories (id, en_name, th_name) FROM stdin;
    public               postgres    false    275   �+      '          0    19883    product_subcategories 
   TABLE DATA           Z   COPY public.product_subcategories (id, en_name, th_name, product_category_id) FROM stdin;
    public               postgres    false    277   4,      )          0    19887    products 
   TABLE DATA           ~   COPY public.products (id, en_name, th_name, product_category_id, product_subcategory_id, market_id, submarket_id) FROM stdin;
    public               postgres    false    279   p.      +          0    19891 
   promotions 
   TABLE DATA           :   COPY public.promotions (id, en_name, th_name) FROM stdin;
    public               postgres    false    281   �8      -          0    19895 	   provinces 
   TABLE DATA           P   COPY public.provinces (id, en_name, th_name, region_id, country_id) FROM stdin;
    public               postgres    false    283   �8      /          0    19899 	   qualities 
   TABLE DATA           J   COPY public.qualities (id, product_id, standard_id, grade_id) FROM stdin;
    public               postgres    false    285   h>      1          0    19903    regions 
   TABLE DATA           C   COPY public.regions (id, en_name, th_name, country_id) FROM stdin;
    public               postgres    false    287   �C      3          0    19907    segments 
   TABLE DATA           8   COPY public.segments (id, en_name, th_name) FROM stdin;
    public               postgres    false    289   iD      5          0    19911    service_categories 
   TABLE DATA           B   COPY public.service_categories (id, en_name, th_name) FROM stdin;
    public               postgres    false    291   �F      7          0    19915    service_subcategories 
   TABLE DATA           Z   COPY public.service_subcategories (id, en_name, th_name, service_category_id) FROM stdin;
    public               postgres    false    293   �F      9          0    19919 	   standards 
   TABLE DATA           s   COPY public.standards (id, en_name, th_name, product_category_id, product_subcategory_id, description) FROM stdin;
    public               postgres    false    295   �F      ;          0    19923    status_categories 
   TABLE DATA           A   COPY public.status_categories (id, en_name, th_name) FROM stdin;
    public               postgres    false    297   �I      =          0    19927    status_categories_statuses 
   TABLE DATA           d   COPY public.status_categories_statuses (id, status_category_id, status_id, description) FROM stdin;
    public               postgres    false    299   �J      ?          0    19933    statuses 
   TABLE DATA           8   COPY public.statuses (id, en_name, th_name) FROM stdin;
    public               postgres    false    301   �L      A          0    19939    subcategories 
   TABLE DATA           =   COPY public.subcategories (id, en_name, th_name) FROM stdin;
    public               postgres    false    303   �Q      C          0    19943    subdistricts 
   TABLE DATA           V   COPY public.subdistricts (id, en_name, th_name, district_id, postal_code) FROM stdin;
    public               postgres    false    305   �Q      E          0    19947 
   submarkets 
   TABLE DATA           E   COPY public.submarkets (id, en_name, th_name, market_id) FROM stdin;
    public               postgres    false    307   }�      G          0    19951    subsegments 
   TABLE DATA           G   COPY public.subsegments (id, en_name, th_name, segment_id) FROM stdin;
    public               postgres    false    309   ��      I          0    19955    uoms 
   TABLE DATA           A   COPY public.uoms (id, en_name, th_name, description) FROM stdin;
    public               postgres    false    311   ��      K          0    19959    users 
   TABLE DATA           �   COPY public.users (id, first_name, last_name, organization_name, username, hashed_password, phone, email, confirmation_code, identification_number, created_at, updated_at, account_balance, employee_id, status_id) FROM stdin;
    public               postgres    false    313   ��      M          0    19967    users_segments_subsegments 
   TABLE DATA           \   COPY public.users_segments_subsegments (id, user_id, segment_id, subsegment_id) FROM stdin;
    public               postgres    false    315   L�      �           0    0    address_types_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.address_types_id_seq', 3, true);
          public               postgres    false    218            �           0    0    addresses_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.addresses_id_seq', 3, true);
          public               postgres    false    220            �           0    0    banks_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.banks_id_seq', 1, false);
          public               postgres    false    222            �           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 6, true);
          public               postgres    false    224            �           0    0    contract_types_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.contract_types_id_seq', 2, true);
          public               postgres    false    226            �           0    0    contracts_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.contracts_id_seq', 1, false);
          public               postgres    false    228            �           0    0    countries_currencies_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.countries_currencies_id_seq', 1, false);
          public               postgres    false    231            �           0    0    countries_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.countries_id_seq', 249, true);
          public               postgres    false    232            �           0    0 (   countries_marketspaces_currencies_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.countries_marketspaces_currencies_id_seq', 1, false);
          public               postgres    false    234            �           0    0    currencies_currency_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.currencies_currency_id_seq', 1, false);
          public               postgres    false    236            �           0    0    currencies_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.currencies_id_seq', 1, false);
          public               postgres    false    237            �           0    0    currency_rates_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.currency_rates_id_seq', 1, false);
          public               postgres    false    239            �           0    0    delivery_terms_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.delivery_terms_id_seq', 15, true);
          public               postgres    false    241            �           0    0 "   delivery_terms_marketspaces_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.delivery_terms_marketspaces_id_seq', 6, true);
          public               postgres    false    243            �           0    0    departments_department_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.departments_department_id_seq', 1, false);
          public               postgres    false    245            �           0    0    districts_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.districts_id_seq', 929, true);
          public               postgres    false    247            �           0    0    employees_employee_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.employees_employee_id_seq', 1, false);
          public               postgres    false    249            �           0    0    grades_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.grades_id_seq', 43, true);
          public               postgres    false    251            �           0    0    marketplaces_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.marketplaces_id_seq', 2, true);
          public               postgres    false    253            �           0    0    markets_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.markets_id_seq', 3, true);
          public               postgres    false    255            �           0    0    marketspaces_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.marketspaces_id_seq', 2, true);
          public               postgres    false    257            �           0    0    matching_types_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.matching_types_id_seq', 11, true);
          public               postgres    false    259            �           0    0    matchings_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.matchings_id_seq', 1, true);
          public               postgres    false    261            �           0    0    order_type_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.order_type_id_seq', 1, false);
          public               postgres    false    263            �           0    0    order_types_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.order_types_id_seq', 2, true);
          public               postgres    false    264            �           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 1, true);
          public               postgres    false    266            �           0    0    packings_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.packings_id_seq', 3, true);
          public               postgres    false    268            �           0    0    payment_terms_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.payment_terms_id_seq', 5, true);
          public               postgres    false    270            �           0    0 !   payment_terms_marketspaces_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.payment_terms_marketspaces_id_seq', 1, true);
          public               postgres    false    272            �           0    0    ports_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.ports_id_seq', 8, true);
          public               postgres    false    274            �           0    0    product_categories_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.product_categories_id_seq', 3, true);
          public               postgres    false    276            �           0    0    product_subcategories_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.product_subcategories_id_seq', 17, true);
          public               postgres    false    278            �           0    0    products_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.products_id_seq', 120, true);
          public               postgres    false    280            �           0    0    promotions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.promotions_id_seq', 1, false);
          public               postgres    false    282            �           0    0    provinces_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.provinces_id_seq', 77, true);
          public               postgres    false    284            �           0    0    qualities_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.qualities_id_seq', 313, true);
          public               postgres    false    286            �           0    0    regions_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.regions_id_seq', 6, true);
          public               postgres    false    288            �           0    0    segments_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.segments_id_seq', 16, true);
          public               postgres    false    290            �           0    0    service_categories_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.service_categories_id_seq', 1, false);
          public               postgres    false    292            �           0    0    service_subcategories_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.service_subcategories_id_seq', 1, false);
          public               postgres    false    294            �           0    0    standards_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.standards_id_seq', 53, true);
          public               postgres    false    296            �           0    0    status_categories_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.status_categories_id_seq', 9, true);
          public               postgres    false    298            �           0    0 !   status_categories_statuses_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.status_categories_statuses_id_seq', 32, true);
          public               postgres    false    300            �           0    0    statuses_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.statuses_id_seq', 78, true);
          public               postgres    false    302            �           0    0    subcategories_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subcategories_id_seq', 1, false);
          public               postgres    false    304            �           0    0    subdistricts_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.subdistricts_id_seq', 7451, true);
          public               postgres    false    306            �           0    0    submarkets_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.submarkets_id_seq', 19, true);
          public               postgres    false    308            �           0    0    subsegments_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.subsegments_id_seq', 37, true);
          public               postgres    false    310            �           0    0    uoms_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.uoms_id_seq', 10, true);
          public               postgres    false    312            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 7, true);
          public               postgres    false    314            �           0    0 !   users_segments_subsegments_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.users_segments_subsegments_id_seq', 1, false);
          public               postgres    false    316            �           2606    20022     address_types address_types_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.address_types
    ADD CONSTRAINT address_types_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.address_types DROP CONSTRAINT address_types_pkey;
       public                 postgres    false    217            �           2606    20024    addresses addresses_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
       public                 postgres    false    219            �           2606    20026    banks banks_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.banks DROP CONSTRAINT banks_pkey;
       public                 postgres    false    221            �           2606    20028    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public                 postgres    false    223            �           2606    20030 "   contract_types contract_types_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.contract_types
    ADD CONSTRAINT contract_types_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.contract_types DROP CONSTRAINT contract_types_pkey;
       public                 postgres    false    225            �           2606    20032    contracts contracts_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.contracts DROP CONSTRAINT contracts_pkey;
       public                 postgres    false    227            �           2606    20034 .   countries_currencies countries_currencies_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.countries_currencies
    ADD CONSTRAINT countries_currencies_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.countries_currencies DROP CONSTRAINT countries_currencies_pkey;
       public                 postgres    false    230            �           2606    20036 H   countries_marketspaces_currencies countries_marketspaces_currencies_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.countries_marketspaces_currencies
    ADD CONSTRAINT countries_marketspaces_currencies_pkey PRIMARY KEY (id);
 r   ALTER TABLE ONLY public.countries_marketspaces_currencies DROP CONSTRAINT countries_marketspaces_currencies_pkey;
       public                 postgres    false    233            �           2606    20038    countries countries_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.countries DROP CONSTRAINT countries_pkey;
       public                 postgres    false    229            �           2606    20040    currencies currencies_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.currencies DROP CONSTRAINT currencies_pkey;
       public                 postgres    false    235            �           2606    20042 "   currency_rates currency_rates_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.currency_rates DROP CONSTRAINT currency_rates_pkey;
       public                 postgres    false    238            �           2606    20044 <   delivery_terms_marketspaces delivery_terms_marketspaces_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.delivery_terms_marketspaces
    ADD CONSTRAINT delivery_terms_marketspaces_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.delivery_terms_marketspaces DROP CONSTRAINT delivery_terms_marketspaces_pkey;
       public                 postgres    false    242            �           2606    20046 "   delivery_terms delivery_terms_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.delivery_terms
    ADD CONSTRAINT delivery_terms_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.delivery_terms DROP CONSTRAINT delivery_terms_pkey;
       public                 postgres    false    240            �           2606    20048    departments departments_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.departments DROP CONSTRAINT departments_pkey;
       public                 postgres    false    244                        2606    20050    districts districts_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.districts DROP CONSTRAINT districts_pkey;
       public                 postgres    false    246                       2606    20052    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public                 postgres    false    248                       2606    20054    grades grades_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_pkey;
       public                 postgres    false    250                       2606    20056    markets markets_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.markets
    ADD CONSTRAINT markets_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.markets DROP CONSTRAINT markets_pkey;
       public                 postgres    false    254                       2606    20058    marketspaces marketspaces_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.marketspaces
    ADD CONSTRAINT marketspaces_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.marketspaces DROP CONSTRAINT marketspaces_pkey;
       public                 postgres    false    256            
           2606    20060 "   matching_types matching_types_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.matching_types
    ADD CONSTRAINT matching_types_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.matching_types DROP CONSTRAINT matching_types_pkey;
       public                 postgres    false    258                       2606    20062    matchings matchings_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.matchings
    ADD CONSTRAINT matchings_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.matchings DROP CONSTRAINT matchings_pkey;
       public                 postgres    false    260                       2606    20064    order_types order_type_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT order_type_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.order_types DROP CONSTRAINT order_type_pkey;
       public                 postgres    false    262                       2606    20066    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    265                       2606    20068    packings packings_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.packings
    ADD CONSTRAINT packings_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.packings DROP CONSTRAINT packings_pkey;
       public                 postgres    false    267                       2606    20070 :   payment_terms_marketspaces payment_terms_marketspaces_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.payment_terms_marketspaces
    ADD CONSTRAINT payment_terms_marketspaces_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.payment_terms_marketspaces DROP CONSTRAINT payment_terms_marketspaces_pkey;
       public                 postgres    false    271                       2606    20072     payment_terms payment_terms_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.payment_terms
    ADD CONSTRAINT payment_terms_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.payment_terms DROP CONSTRAINT payment_terms_pkey;
       public                 postgres    false    269                       2606    20074    ports ports_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.ports
    ADD CONSTRAINT ports_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.ports DROP CONSTRAINT ports_pkey;
       public                 postgres    false    273                       2606    20076 *   product_categories product_categories_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_categories_pkey;
       public                 postgres    false    275                       2606    20078 0   product_subcategories product_subcategories_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.product_subcategories
    ADD CONSTRAINT product_subcategories_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.product_subcategories DROP CONSTRAINT product_subcategories_pkey;
       public                 postgres    false    277                       2606    20080    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 postgres    false    279                        2606    20082    promotions promotions_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.promotions
    ADD CONSTRAINT promotions_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.promotions DROP CONSTRAINT promotions_pkey;
       public                 postgres    false    281            "           2606    20084    provinces provinces_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.provinces DROP CONSTRAINT provinces_pkey;
       public                 postgres    false    283            $           2606    20086    qualities qualities_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.qualities
    ADD CONSTRAINT qualities_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.qualities DROP CONSTRAINT qualities_pkey;
       public                 postgres    false    285            &           2606    20088    regions regions_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.regions DROP CONSTRAINT regions_pkey;
       public                 postgres    false    287            (           2606    20090    segments segments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.segments DROP CONSTRAINT segments_pkey;
       public                 postgres    false    289            *           2606    20092 *   service_categories service_categories_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.service_categories DROP CONSTRAINT service_categories_pkey;
       public                 postgres    false    291            ,           2606    20094 0   service_subcategories service_subcategories_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.service_subcategories
    ADD CONSTRAINT service_subcategories_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.service_subcategories DROP CONSTRAINT service_subcategories_pkey;
       public                 postgres    false    293            .           2606    20096    standards standards_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.standards
    ADD CONSTRAINT standards_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.standards DROP CONSTRAINT standards_pkey;
       public                 postgres    false    295            0           2606    20098 (   status_categories status_categories_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.status_categories
    ADD CONSTRAINT status_categories_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.status_categories DROP CONSTRAINT status_categories_pkey;
       public                 postgres    false    297            2           2606    20100 :   status_categories_statuses status_categories_statuses_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.status_categories_statuses
    ADD CONSTRAINT status_categories_statuses_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.status_categories_statuses DROP CONSTRAINT status_categories_statuses_pkey;
       public                 postgres    false    299            4           2606    20102    statuses statuses_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.statuses DROP CONSTRAINT statuses_pkey;
       public                 postgres    false    301            6           2606    20104     subcategories subcategories_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.subcategories DROP CONSTRAINT subcategories_pkey;
       public                 postgres    false    303            8           2606    20106    subdistricts subdistricts_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.subdistricts
    ADD CONSTRAINT subdistricts_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.subdistricts DROP CONSTRAINT subdistricts_pkey;
       public                 postgres    false    305            :           2606    20108    submarkets submarkets_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.submarkets
    ADD CONSTRAINT submarkets_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.submarkets DROP CONSTRAINT submarkets_pkey;
       public                 postgres    false    307            <           2606    20110    subsegments subsegments_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.subsegments
    ADD CONSTRAINT subsegments_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.subsegments DROP CONSTRAINT subsegments_pkey;
       public                 postgres    false    309            >           2606    20112    uoms uoms_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.uoms
    ADD CONSTRAINT uoms_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.uoms DROP CONSTRAINT uoms_pkey;
       public                 postgres    false    311            @           2606    20114    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    313            B           2606    20116 :   users_segments_subsegments users_segments_subsegments_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.users_segments_subsegments
    ADD CONSTRAINT users_segments_subsegments_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.users_segments_subsegments DROP CONSTRAINT users_segments_subsegments_pkey;
       public                 postgres    false    315            C           2606    20117 3   countries_currencies countries_currencies_countries    FK CONSTRAINT     �   ALTER TABLE ONLY public.countries_currencies
    ADD CONSTRAINT countries_currencies_countries FOREIGN KEY (country_id) REFERENCES public.countries(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.countries_currencies DROP CONSTRAINT countries_currencies_countries;
       public               postgres    false    3568    230    229            D           2606    20122 3   countries_currencies countries_currencies_curencies    FK CONSTRAINT     �   ALTER TABLE ONLY public.countries_currencies
    ADD CONSTRAINT countries_currencies_curencies FOREIGN KEY (currency_id) REFERENCES public.currencies(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.countries_currencies DROP CONSTRAINT countries_currencies_curencies;
       public               postgres    false    235    230    3574            E           2606    20127 I   delivery_terms_marketspaces delivery_terms_marketspaces_delivery_terms_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.delivery_terms_marketspaces
    ADD CONSTRAINT delivery_terms_marketspaces_delivery_terms_fk FOREIGN KEY (delivery_term_id) REFERENCES public.delivery_terms(id);
 s   ALTER TABLE ONLY public.delivery_terms_marketspaces DROP CONSTRAINT delivery_terms_marketspaces_delivery_terms_fk;
       public               postgres    false    242    3578    240            F           2606    20132 G   delivery_terms_marketspaces delivery_terms_marketspaces_marketspaces_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.delivery_terms_marketspaces
    ADD CONSTRAINT delivery_terms_marketspaces_marketspaces_fk FOREIGN KEY (marketspace_id) REFERENCES public.marketspaces(id);
 q   ALTER TABLE ONLY public.delivery_terms_marketspaces DROP CONSTRAINT delivery_terms_marketspaces_marketspaces_fk;
       public               postgres    false    256    3592    242            G           2606    20137     districts districts_countries_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_countries_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);
 J   ALTER TABLE ONLY public.districts DROP CONSTRAINT districts_countries_fk;
       public               postgres    false    229    246    3568            H           2606    20142     districts districts_provinces_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_provinces_fk FOREIGN KEY (province_id) REFERENCES public.provinces(id);
 J   ALTER TABLE ONLY public.districts DROP CONSTRAINT districts_provinces_fk;
       public               postgres    false    3618    283    246            I           2606    20147    employees fk_department    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.employees DROP CONSTRAINT fk_department;
       public               postgres    false    248    244    3582            J           2606    20152 E   payment_terms_marketspaces payment_terms_marketspaces_marketspaces_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_terms_marketspaces
    ADD CONSTRAINT payment_terms_marketspaces_marketspaces_fk FOREIGN KEY (marketspace_id) REFERENCES public.marketspaces(id);
 o   ALTER TABLE ONLY public.payment_terms_marketspaces DROP CONSTRAINT payment_terms_marketspaces_marketspaces_fk;
       public               postgres    false    3592    256    271            K           2606    20157 F   payment_terms_marketspaces payment_terms_marketspaces_payment_terms_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_terms_marketspaces
    ADD CONSTRAINT payment_terms_marketspaces_payment_terms_fk FOREIGN KEY (payment_term_id) REFERENCES public.payment_terms(id);
 p   ALTER TABLE ONLY public.payment_terms_marketspaces DROP CONSTRAINT payment_terms_marketspaces_payment_terms_fk;
       public               postgres    false    269    3604    271            L           2606    20162 A   product_subcategories product_subcategories_product_categories_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_subcategories
    ADD CONSTRAINT product_subcategories_product_categories_fk FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id);
 k   ALTER TABLE ONLY public.product_subcategories DROP CONSTRAINT product_subcategories_product_categories_fk;
       public               postgres    false    275    3610    277            M           2606    20167    products products_markets_fk    FK CONSTRAINT        ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_markets_fk FOREIGN KEY (market_id) REFERENCES public.markets(id);
 F   ALTER TABLE ONLY public.products DROP CONSTRAINT products_markets_fk;
       public               postgres    false    3590    254    279            N           2606    20172 '   products products_product_categories_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_categories_fk FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id);
 Q   ALTER TABLE ONLY public.products DROP CONSTRAINT products_product_categories_fk;
       public               postgres    false    279    3610    275            O           2606    20177 *   products products_product_subcategories_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_subcategories_fk FOREIGN KEY (product_subcategory_id) REFERENCES public.product_subcategories(id);
 T   ALTER TABLE ONLY public.products DROP CONSTRAINT products_product_subcategories_fk;
       public               postgres    false    279    3612    277            P           2606    20182    products products_submarkets_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_submarkets_fk FOREIGN KEY (submarket_id) REFERENCES public.submarkets(id);
 I   ALTER TABLE ONLY public.products DROP CONSTRAINT products_submarkets_fk;
       public               postgres    false    3642    307    279            Q           2606    20187     provinces provinces_countries_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_countries_fk FOREIGN KEY (country_id) REFERENCES public.countries(id);
 J   ALTER TABLE ONLY public.provinces DROP CONSTRAINT provinces_countries_fk;
       public               postgres    false    283    3568    229            R           2606    20192    provinces provinces_regions_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_regions_fk FOREIGN KEY (region_id) REFERENCES public.regions(id);
 H   ALTER TABLE ONLY public.provinces DROP CONSTRAINT provinces_regions_fk;
       public               postgres    false    3622    287    283            S           2606    20197    qualities qualities_grades_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.qualities
    ADD CONSTRAINT qualities_grades_fk FOREIGN KEY (grade_id) REFERENCES public.grades(id);
 G   ALTER TABLE ONLY public.qualities DROP CONSTRAINT qualities_grades_fk;
       public               postgres    false    250    285    3588            T           2606    20202    qualities qualities_products_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.qualities
    ADD CONSTRAINT qualities_products_fk FOREIGN KEY (product_id) REFERENCES public.products(id);
 I   ALTER TABLE ONLY public.qualities DROP CONSTRAINT qualities_products_fk;
       public               postgres    false    285    3614    279            U           2606    20207     qualities qualities_standards_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.qualities
    ADD CONSTRAINT qualities_standards_fk FOREIGN KEY (standard_id) REFERENCES public.standards(id);
 J   ALTER TABLE ONLY public.qualities DROP CONSTRAINT qualities_standards_fk;
       public               postgres    false    285    3630    295            V           2606    20212 J   status_categories_statuses status_categories_statuses_status_categories_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.status_categories_statuses
    ADD CONSTRAINT status_categories_statuses_status_categories_fk FOREIGN KEY (status_category_id) REFERENCES public.status_categories(id);
 t   ALTER TABLE ONLY public.status_categories_statuses DROP CONSTRAINT status_categories_statuses_status_categories_fk;
       public               postgres    false    297    3632    299            W           2606    20217 A   status_categories_statuses status_categories_statuses_statuses_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.status_categories_statuses
    ADD CONSTRAINT status_categories_statuses_statuses_fk FOREIGN KEY (status_id) REFERENCES public.statuses(id);
 k   ALTER TABLE ONLY public.status_categories_statuses DROP CONSTRAINT status_categories_statuses_statuses_fk;
       public               postgres    false    299    3636    301            X           2606    20222 &   subdistricts subdistricts_districts_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.subdistricts
    ADD CONSTRAINT subdistricts_districts_fk FOREIGN KEY (district_id) REFERENCES public.districts(id);
 P   ALTER TABLE ONLY public.subdistricts DROP CONSTRAINT subdistricts_districts_fk;
       public               postgres    false    246    305    3584            Y           2606    20227     submarkets submarkets_markets_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.submarkets
    ADD CONSTRAINT submarkets_markets_fk FOREIGN KEY (market_id) REFERENCES public.markets(id);
 J   ALTER TABLE ONLY public.submarkets DROP CONSTRAINT submarkets_markets_fk;
       public               postgres    false    307    3590    254            �   �   x�3�L�����KWHLI)J-.�|�c��[��x�c����	b�l~�cփ�vl���vlz�c%P=g��gRQb^r�v��j� ]Ɯ������l�� n;ؤ-v�|�����N�y1z\\\ �%�      �   �   x����
�0���S�.���4���<{�(�Ł��7�!��������JFd���&	��~��g�|�����q��d��JC%b�I{�-�R�6�2�(x��y��o5o2��4�{����y�H�m����i�C�u�S�>[�(;�-Pʖ�8�q��X"a��'k���gm�2YJ9      �      x������ � �      �   |   x�3�t��O+M�)�|������;�?���`�Z0wރK���`G;Xj���X�`�&��1Hoj^jQz%'L�F��v���X����&�	�O}�cڃ;��h���`r)W� z4j�      �   o   x�3���|�cՃ���Mvt?ر����;�>��Y�`��;6���A
fr��q�($��%&�pq���;��a�"��r��n�E�E)sc���� [�he      �      x������ � �      �      x��\Oo�Hv??
g�0���Q�D�")Z����K��؜�D%��>m� �%H9e�`A.���"�(�=J��:-Җf�<;]=�իW�UY#��[��Vk�$2� �*�����V������"E~��o�dY��DZE�r�Nt2�jy]���V��D�m�^i�O�I��.$7N68�?�V=��ʀ�/@7lP�$���xa�-D�I' ܄	#�g �4�-����J�r��3� ��*���%_-b��9��+>�U/�?,�L$M�itR#cy'	�&�m�~*�m.���x�C2�!�)��U���O��U�zY�]_��ݟtL���O�F��2�V�|�wk_���7,���ђ����˦�ӚT���<ib��J�֙8�s2�_NqN��N0��8�I7�-�\������,��[�1�id$7!�[�#�Ee�<��)�]���n��	�H�F{��PUs8;����4#��Ӡ�Iz�_O�hM�Z.�ϧGJ���։�g�A>��V�_���?����48ky�v���& PE�u�S�݂���a*�ar��_2��u�,�6˗Z�Z���B-�Z=�*�V0x��<A�"0��F$sl����\]��[@��e��*D��\{Jl �:�E��5jQU�/�Z��Q+��$�	.�e�H��������&���3�M�. ��T��"��ˌ=b�53j�ݜ}`��x�𷖪�O�M[0T��3���G�Y�r���>���U�&�̍�И�����g�s��kԺM�X�
@.�$kA����y��ZC�M5��ã�s+^�(�M:��|8�����Hu��ī������1���d޻eP�ߣ���QQ˰�x��W�dP]j�4g�_�-v�qgՊ�/�z�� |
�.�mr���Z�z��b�Һ�a8�$ZG��Rya�Y8(a��8y �A5����|d�/��*'P�V�.è�fǳBta��bi.5���7J�S��u�о������R����J5�
}�a+M>C�J]����Ԩ���� �u�N!X��	�`Pg�96`C�qi&�X�9!ӛ��	���7�����Y��i�̃��AZ �0�c85�agdJ��'��K���4@.@�&a��߂GS=,0�K�2� �+��F��i��k@�yS`�»�r]a],��I��i�>�TȼUpCA��H�a�8d�ќu�&�g�R�n�G;�J��`�l��[)3s� :�_�N��u|���E���O (ZM����.$g�W��� DN����UGL4 �d�� :�+�ǋK^�9A�2����j�53^�	g���z-#� �����J3F�
�-�Z j����j��&T�!�q��B�f~�o@c�dV�ѽ�<��֪4�܆9�q7�z?{���H��x��K�/q�^�}Є�߰�&�9s�����@�!F4E��Ѣ,�
K�JTsjAZ��8Y�ť���?+ւ)��*X0iYWavwY�c����w҆/r�9���cxu�Y�ԁ�E��Ѣ,z���|&j�� "
���2x��/�%�
	E��']��v^!�ϸkejǋh��{���9nP��x�C��Ʉ��?��;Y�:W)�焨c�ƘAH��:Z�����S ˴.���VA�V�μ������|{B�.�����hPv~M2�o��2�9Y�9f�����Z�:(F����a�2���ѱ�Z�Y��ӡ� V�^�Sl6u(�,;��?#:C�&6˟R
���o��.�/ ����^=`�e���M��	��G�6<HY����4��J��5|v��1�0P�K�J��H�{�>T�>`t����"p�i�.7�S�r��Q�3P�.�}����&�p�Qaw
IN7	�W�l3Y'��5�J�G˾���MF�uɻ���Ncto��j󢶻b>
��8ŏ.;UA^�OMY�CQ�Y�P�H�-t`nRd�T��V^��/j��
��&�퀠ѲK�Ѽ$ �&(�: Dٌi�:U�n7J�AeN���V#+���_+����d�f��F��$�X��D�%�^�+b5��5\��i(�;J�F��6���L0RT�#O�N�B���W`y`ף��y0z�$O� �� ^���ً]%���	6߮Å��;+ @�P0��M�F�]X��m�!��A̲��m�K+\(�n�λhw��E���V*��-�}�����I6y�� �R�>���՛uꩈ��^ �SY�E�����t�A�P%�<!�ʹj�K5s@�s@0"�1���E�I=���b�'( ���IqO�۳�xy����rA�J��0�h�v��L7���� SI�L���.ow�{ctZ��-��4��,�>>Q��0Zh^��e֗�i�Yl�a�ws����*�s2�6ˑY@�]���N1m§U��1�L1��G�?�����s|.$��ܳU�N� @��T����@;m�#,�?��l-ȅ��F�����*Q�(6��!�3v��4�ڵ��QK 2�,�`��خ���BeA�̡3�B&gG�J��0ɢ�Y�QB��=�G�{'�,�!hD�g`4_Z5�G��vs}i0��1��b�+/���d��4�|���`B�H;����A�)v��>h��3�~N�� �Az�p�ϧ� |M��`��<<n�c�f �+_8��l��c� �-F������e���dPE�V�+�^&;�TK.1�%�#�H�x}�a9�ہ�*M��]n��#�E.E���R��5Ӿ �P�`4����u �W��p�9�ʃ�u�$w�_|[{fG��tsC�@c��xm���&�����e�&���	Hr3��AƎ��n�3$�0�!���t�ʊ���rɱ�i[T�}'�,c���:H��a�����:'/G�[�`�u8 �b'��wX$�8��n8�{B�;�hn� x}6��>FPx��@�
�'�}�ѯ\F��U��k���@6U�I
Fs0,@�(�5��9�:G�Ȼ.xvT�D�Y9#�[n�A�r��������.2���zXa�y��k��;��.� ]��d�r��GWlџ���+|�c�~�z ���w���C$|]'O;P<8��:��!�ɼ�i��Kʳl�&Ivk0Z���>:�nv"qu\x1�j8�'�Z���M¬t���:�-F���P1�*L����A#�ʬ�9�Nf6'�U&6�SH=1�"#8v�G�.n�{�2��¼���Z��u���U$ɞ�'���U�(k��o�]u�z�����.�B
�hLU�J�h��#���B��z 8U�}�hn�@��-S����a�k��#S	��&��їpg @� ��\hn�9%�&e�� �B܏ܑ��~�MLuB=`en�+c��Wq�u�(�3�L�� �ԗ�\f?�\�w�@[dLv�������x���f���"�������7f]��!��#o4@�&�>/���*[��;Mt�65NE���_���i���To���C|�n��33� �*lw��Ȝ�}Ǳ�V��p����A�*��Â7	�y���q�7 ����˟� ��kM@̹Y�Mɳ��^$
͑T_��h�uy>�C�L50��D@�R-�� A
��g�&V]�1�]�2�ݵ�=�<�]U�����e�dn{�]@�/�&#�w|/��y!�a
a�=~�*y��<���0`^dc&)�w\"��5�����D�<Ӆ�ʌ����^��̉ dy|1^�R�.��`�l-����ؙ�j2vz�P�0�4L�1_*C
�@}�ɖ���Ke�}�rJ�*;<7@`Uv΍|�ih4
�e��Q4�ع�A���N�x�)wFCpe�?�r�Q�Z�-�nx"��0:� ����y�{������T����*Z���6m.`�-�P�g<�I���m��a>��{ �L��C���F}>����66��f�����\|��滫il'�ӫ��d��٢�}�����in�����7&������/��U(��+ߝ�y��ՋP+���:.E� �  �ŞC>~j2}���oun�'��
�ꅣ�)��OL<�L�&��������9�h�͚漛՚e|�ɞ�����G�T�y����f@q)��z ���?��Ly�+�W��j��d�N������D�\�\�_�dQ��\vsD�]�;�V�`���kMXk�d��|�G-�J���C�����
^k�J��_�Tk
���n�	�c�W%;�9��mP�r�i#�H��hy��b�E�[ ��rc��C?��]�A��Nׯ���BQ.ê����^��OA��Z5 2 ������x�גf�"����Ȝ��@�4��
�'2~{բo���?��1����u��!�/R�yD�c�|n�;3ԥ�|x>;�Q��ܠo��f���>�>�Ƃ��G/�Hh}�ߵ���is�W~������oS]��y�W{�Y�w����S��N���5XJ�l��̡z 2H�7,��R�/��V�A]u!G�]���5�|
o�l�#��#�˶��;I���Q�K�j�_�ea�!d��@Pn�r���:V��#�e����e~��L]GU��G��0�>��J>s���֠����Bܛ{�����E���|�>P�=oo0�+/�8m���:��_�]�!8����y'�:�@-7uF0Ԑ�:8���W�h'?ټR`� ��(9��_�21�y
,�K�9�_��x��s��\�Ȧ���<x��*>G���C�P�`�h��5
`ѵ�XF_�l}�����n�^� j�A�R0�2�	�"�����0���&�k6�#�/��*���	4E��|�E��0���T�=|�,�	2 )��Ȅ��')\��k�`)�I�n�u�lJ����>����s~�1�̿r;26h<W��(�`��e��7���4��1�G�'�F��o��� ���|]%�Beϧ��}V���b��a߼�i�×�k�9�5�
q'�a��?��W�;�>U��9�;����o����br샰�2v��w��e�������ƣjHO?>�}�)���2�ň�Ԣ��I���_:�7Q�T����1(@�*X��s�ڊFo���18�\� ����>�^'�����/j@2�@H��G��$�˷S�����냠��������Ȧj>�6�Sn`M�4��Ԑ!h�����lx�p��"��{T��Z�(4T�t.8!�耸�!�.
|Ti�}�2s@�OY��y}�W�4�����b6���n��^%�>7dIl����?<?�1��<?���ӿ?������<���#�6�MUY��vq~y��*��/��������������������"��o�ʪn0�;��ጂ[e^����<?���ӟ(�����L�g�fm�뒫n��L>���dy��#T���[�?yǯ0�P���;����?d����}~z���t�\�[�m�)�_������ �\�1      �      x������ � �      �      x������ � �      �   D   x�3�v�;�<ر����`�����v�<ر���� ���vL�2��p�;f�UM����� ��&[             x������ � �         =  x����N�0���S���L�Z�T��*��XmDH��"a)�T`����.os�B7El��l��;Yw[�	sʯ	/	g�τSʯǄO������_���k�ݕ�1�:
O��w3.#��l�?�~'��ά�=Y��(� �!�,l{)��V���%�(exbߒ�Wq����`��xMa)�ތӑQq_��6
CZ�1���G�*x'a��Ɏ��h|_Z���G�y)��eײL�bV�G�
t��un�b��n�ă44o���@��y܊y=Q��s@x�e��ӆ�K�X�m1a��q�Wc�;U#         D   x����@��PL��N��%���ؒ�h�e.Ls��7J�QA#vǜ^ċ�>��	�M��{H�M'            x������ � �            x��}�n\W����x��g>ZV4��&Dz�r$%�	���Ao&�h�t���M�&�b�$��VA�j�o�)��"b�L��(�P��+�9g_��k��`���]�ƣ���7�.�?]��ty������O��.wҿ�ZQ��~W/�O7#r����ˋO��*�Q���}5�D�+����g�.��?���Y\+��2�~�|���*o�� ?��ֿ(���r}8s�-�̗����S,�������2?A��[�?]����bq�6��Q��-������A9�i���>�qN���~�q^�_�h֯��O':rO�gaP�҄�Z��m���-JS�/nGs�&�+�'d�!D"��Zq�ܜ[�(��C��e�x�d;�ۣ�Žr��ϓ2��0���O�;4��rm=}��|R������-����h����!�iNʧ��re�������_�n�igOM�O��	�,+㕹{�g���OW���}Z1w��r��Ie_����l�|�9��U:.K�~�����r!3
�^�\����4�fx%��l�����n�������N��p�&�4��r�٣��d�o��|�o����=�ko������W"�?>�uI,�{�*OIG����r��<I����uZ�r���S<����W������v9ȕ�,V�͙{ĳ�fx$��z:z��~���S��|���ڤO5Y�<��X�K^K��n:?�^-�c?p鞼�Ҥ?��t�_<�k���"-���� g����/�o��¶�x�feE�9;�.�ͯx����6�'��
w~��_�m�t,������ߪ�f�4Il�検b0�[�}�}%�4���xT�����,��B'�rk�/�V�5��1MsFա�&ys�2�ޑ�86�Β]f�$�3Y3:��iA�+�&A4��{�Z�!|�wY��,�|;���X�[V��v�_0�f=m��ܭ���n=a6��7E��eIb���B���$��fZ��I��S���gGD��p�D��&�6��jee��ٚ��n��i����|�8��͎���r桉k�Mҫ|2�����M>��IB$FM˺1�P]B:�𾻄V���x6g?��t���O0�$�g"��=O�1s�}~��>[���E]F���E�D�Q�i;SL�#PMј��<.쪬�pa%i	�|�W���a�ʿ@eӞ����� �f.�c0�L!���Sxj��ZZ������]���*���ݘ��|��F��*�e�����0)�>A��s�JS�#.��V9(
K?1�������c�m���Uh�Zx:�3��p�?M���2 ;���+���r�T��{��d�uE�EI�5�L��E���Ü�f����O;�x���<m�-�AG-ѥ	+��=��O� {�M�NR�xY;d-	�3m�ļ�|:!v�,��<6INyw�f^{��AL�h�x5���;2�j�����+�^�#���� �m��d[T7@j$^#>����3����_3�K��ע��xP� �R�Y�R^W�n�;��"O�X:C
���� ��LO�G���)�a�kjn��"����l
gLq�(�!".T�O�Yӛ�@Ul�F��&[U4������fq���'u���+a�� ����_��CD����p��K���F�K�-�R[�O��|vy��Ǵ��->/�K�y�-@ȼ6~M?�n��6A���|:kOH��P�\�:�y �V�>�)�j��֯lu�Uv��xG������2�eb@o�9^6m��3����:B�V�hs���\�0������Rʔ�Us!Ѹas�U�=��)͑�ۼ�>��=�6瓪�󑻬�����-c�����5�7뎪n*���hو�Du�ABk���M�j���HRȚL������
|�y������83>N��[���3v�/��oӔ�!�Y/8ލj�btu��l*�N$�sew���ˋiv�C��_n$�J^WO��ڌ�cU�L�x�X�g����s(g3���a2{�9oØ��g;U�~�Sڤ斣��9�<��j������1&�WYÒl}]��S���@�a3Z�b踝��n7]��b���˭rm<c��8�yE'Q�Gd�u����dȮ��Qdq�2�ۼ���f��hDf��J��ywSΟ�&�P}1Mb�#��*v
��]�mG��H��d'��`B��Z�Kv֒G_'�+{�6S8���̀��,�M�;���	Gs�);Y&7`�_�QJ�IG�B&�&Kn�Z��1%5}��=�K��L3	�X�/���ks���~�Ku��h��S�B?�P5?͙c�r����3kBs�u���:��,Z̦�,���ꦉ�Or���F,�08ٜ���,sS��	�6o�B����"��F��z(��<<L�" �[,��z00���oԓ�l1����`�^�_/.�>4���|%^��5k�|wa�ß��)Ww�:�N�t��(G�O�+��XH���.M���o��:�~VǑkvoΪ�2�� ~UU`vB��$3W��k���X�8(yׂ�LV�f��{��9����*�ѵ�����"�@<y�4�U9�0���u���+t���T��(��=[��3V��%ąXE���(�|Yai&��!Z��U��uU�A�X�j��.&�<�@uT��`~ɾ�LȽ
��㌲[�?4��kE� �-��~��U��ɼ2ٌ�b�� m�?��t���mK��1K=2u�ZM%���"2��#��.�5Y��m}��� 7����a�qŮ�8bS����ze��h$~h������LC��6R�5���p,����1�a��oqwu�����XK�7o�ZF���ʏvh�c
9��e��O�x����r»JG�����R��Ĵ<spM�����[���(1�����:�]+J�l]�542�٪	��"��8�u�����/�j���unl�Lr�����b����mfI��ʰ\�6ɋ)%�Љ:8��T�jۂo�'���A���i6�@>+����H��oc�{�����<���Cc5{ٯ���e�EA=s<��H���F�ޅŋ�@� �=Mi�mF%>������d��U"�����-󿋗�v�(Vfz�wԩ�l7��j�w���ֈ���0|8ޓM�HY��ſ��yڠ�>|�R_�qD�螛\�]����55�{�إ7؆�xǅ�[+�KV��^}�?M�C��LG�^?ӏ"c:aK�����L�<�Ґ@�,�� ���ES7e�Nḏ��}�&��eJ�JHax�|z6�s�k���	6��ID��|��x��$��8=�cG�V�����Z��12ȏ����`�_�i\��`$��D�Y�!�-�9��`�����=u3}�ZE>�jtnw�d�WVJ�6Bv���פ�<�߆2������*���͹)c1��[xR
m�='b�҈��Hj�!��a���AO��q{+e�����H�$��	�I�OJ�q ӡ�L�E���0��}�@՘)���G`������IHh��n:���A�۔&k�<$��D��#%P��M��P��.�uGp �*hr�n��=Nm�$�k��A�S���~&���A�2���QUa� uy־�Mn�|�7�oO�&����J�s�=fp˨��j��r�t��ݹsP9�oB$�f5��������L��ŧ��H�N]%�r�#hlQ������Y��I�#4�.[s�tC��&��;M��i������ũ��܃�=͹U����Ti�-��io<,mg�FZ���y���0��r��k���,'s}^G!.<��#���j��a���A���"�o^�C�P��6�SƈКG?��n׊/L�8�(�	��8X�7P)��0�615�|_�M%mX[���R6+:�e?�9�b��0>6o{J�������=�p�J erӶ�K�<8ۿM��I���F�_�'q�f�l����3���:�h�q��ꐼ1���$�)�Jq��3k��������m���K�7��B:����I9���K�E�'�x��s�c����5�'��a��D�    G��=B�;b� ��^��i�6��	IJ�ʎrE±t���W.���È��}�P�]J�cv��%���	YG&����Fq��ʍ�%�/�f���r�jK�$}b�%��סs���,����JJT�NR����W��'���`3IS����}0�s�tHG�AI��@YL��H;���W^	n�"��<E��X3/��>���FNx;	ٓ�S�����$�ԡ�1uhv�N�"��@�Sej�Ն�v��T�f��)��c�K	���^e'�6��Oș7��-����۱�=/S�U�����i:�g��?�Oi/~��_� :F��H+N���Ӝ@��y�5F�d){�7J�oe�~}i�֠j�*/B��,S���R�&+^�e��!"P��!�Y��`�q$ː,b9�<>]Vu���|Xɒ��� R�{�u�|L��Z�i�WVvx-�ۣ�"�@��x�']�!���Н�T�kM]�;��+%sӭ����	�I�)��9F�a`6$��dE�`��1�)�(��7O�)�C$¹".&����u5�tc��^�Id0:�d�ʃ���2d*�e�I.��
���M���ÜWU>��j���Jo���$��s��A���x�*)���� �Fs�iAï�esvV���C�|,!����1�G)�J�
�\2ư��)ޔ�C������D	8v<9��$�dzs��SOfr��u+���?9�S\�o�}�p������^��"mF����~ҫN���~o����NxV�5�t��A%S���D�����rh�X�s�'�����/`�l�	�3v9A����l��9^g���oܶ�	挒z^�/�rOە���7��~9q�N�L�7�F�n�p?�+~�M�K舩�OH�x��.a���$��6<^sZ|�v���k�=�A:vTG� $p8}�wk�na���?��� f�i�kKxa��n��%}l���aһ���!��O�j5-gH�N�kV�S�+[�Qc��ް4�=�|�Df��r9������6�9�{nqɊ��gM���Ͱ�[\0�{d�4R,uK<@���Z�g����pCK$%�Գ`�!k�d����m7,���mc�|{�:��y<���܋C�s�i*eWj{�n�3�O�=>z_�bm�n�Qa��K�ɴ������YҰ�Ȟ[f/��`�|�������0�\�]���*�'��$X/�#�ßX�&�S�=&���� ��AAz�S��K"�]�05�vLg|�&�g�����}B:��Ӟ�x	9AW"
�1$� y��AAHJ�F0�8x�����p���L*>V1}�����e���VxS�2�J���QzC�z���YW�U, P7��O��yA��_�u��T+>@-��Z9�X
��b���_��\�J��2�&*����˺����o=��[���;@�`���<��� /-Z�����`��y�7]*�=*+���<���I�G�6�N�61��_�Q"]V|\Q�޻nS=~m�CW��2�E5��W���M4��x���K�L��/� �$X��~js�� F��>��!=�(�J=	�u�E�W_�zI�w�����\��<��l��s77o�YvF�nN��Yt$��h%����K��V:ُi��f:�H��7Dn.�"Z�R���2�J�>Ь���f���m�p��MTl��~�8�ߑ��+��aFג�A�4�a�am҈cP,�D&��c	�0#v]&ӓ>�=�_�XJQǘ��/��!��կ�F����m��ύ#.�}K���ʱ�4�7ن�re0��-3a�s�����w7��y��̙�m����sUC8��hmN����t"̟1M@j�K-��5�_و��gfY�Ύ�;�r<�)�W9�"[�IMLxR��^�Wcmq0�|z��3_$�y5�VaISn����Qj$>PA�
T]̪	�t�~fFd�XL4��/�b'���BE�4�3yV��\�i;��-���������V|&Fs�GQi��r�*q�ҽ8�}��ڣ��$NH%�P��-�1����o��R��8��Oم�|�5MϤ�	Y��w�o7/1�:��"'����Z�;�;�h:q���Ka��dܐ��Rv5m���U�j1������N JӍ�_5�������D�!�f�y�zrd��L�E�|!UV]&7�u;�\ɳY���OJb�J�bK��fi�|谚���$.8�"N�9D�w�p@B����(��Ǽֲ^f/�P�����tx���=Gkh�ԑՔ�dK� ��*�?g8-C��M%<��A��A�e���ҁ]M�J��V�Qa���IO���)����l��+��^-�g�} k̨��kх,�����<B�������	>��y�&��0T�7k�.��h��e��	N5 m��,&�Z'���3M�4�*84\�{ ��r�����h�\/�f��x�����!|~ϫm���Q���!A�fM�g'Q��C����Hj�]�]g�8��̤�"KLJ�j��I�E�|%ކ�`�;�7ز舣��T��T�I���X����Bb$�*�Z��P��H�aRj��/�~ ���.#�1J�^xV��:�X2�ǋ��_^���!���װ��p�VJ|�·>��72=}���}NA�����N�g����,�;��Zb�DI���D2|[���Fؒ1�a�����ś;�|�+�z:�4��P����V{Ѓ��[�
> Lө7C1�Đ�kR��A�J|�f��|��څ�2��p���Qס(�۟���[p{��ߓr3~��/Ԗ9觖d-�&?j"\%�|�
���=EXe90G��S\S%��$�)��D#Bi�V�g}s��P��+iF���58����ߢ��s�Ф^�CmS�e�n�ׄ%�C�g��6��4|�^C��H�>Y�u�;�^g���㼛��{n�0p ���x8�/3R���Dْ6�i� mu���MU���	�NpQM{��jO�$���+��(U�K��{�G��/B@�1��5<��|�tGX�n��H�y��,*GANZN���8�� d/Q01"�ح�UK}���m'��#�x@��R5x�/XW�![�rh�Ѵ�cU���ff�^`�÷vdR�r�22�-��$e�Ԫ
	���+l�G�'=))HI�~�rM������J���~�qs(@���twv��������]w���,�j;�{�A.e5��o�7��Z�P�]�����r�:0��r�|<+O]�!y�'<��BA�d~8+;�ㄟɛ�F�C2�׎���/���NH�>�,��G�;*E�4-�r���2�@י_��q�E�9HS���՜�zkC��%��V_���,J[���8��Rs�.�㾨fRISb���W���w�dD.pt���G!�}ǫ[oABו�&���k'K�N��� �+�B�c��4ۿk�K�0x�a6.�0)\`��yK��������"�p��n	.��3�׌'zn+գf��+<M�P [:@Z��c�l��dԴtx�E�5��]���(�@Ie�Y�1�wYlň�E�:��g����.��PTh=*2���"�����k�V�o~���p�����hb�O�����O1��m:IM�l8`'�G$axq���D'F<E@7�/W���rm4A�;��_Ch�s�������y=Գ�"4�Y�N��,�X�B}�x��7$%ό��\eً�w�:{���R�Ӽ6����[��Y����'$���2�Dؼ��H��V�i��Ly�D��5?��g�3L�R�(��oT ��U4�:B�*�����/q��j0�z�]T�?ٵ�q�G7�j����U�2o޴��/�.��G������
��N!��%ᓺ�֐1�Q�U4��FMO�T�d_y�0�y(l1CrV҅Q���<{����Ԛ�ݫ4�A���#ߚ�<,g&��n� �N��!�`VR9V���n�8q���r.c��e(n��>�B�U���f��~14^�_�GǱ�����O��H�T�{h:+�sߠ:���e�?�sN���S˺TO7�6 %9�I���q��s�'n�    ���VD���#�M�cK���M�N��{5LA��WY��:�*/�Wn3��0������vZ�ꐋP�!�[hpY���O�r����1u�o͵@�'�/��f�y�W�̳lE\2���Q�9�;򍡁�}��ӽ�==��6n,s�b��ta�Vq�����I{�_�V�*��y�Á�yd��(�1�Ӑ��}�^[R�f���h�o��i�ZDI���n�m$HL����*K��6��m|3fcz:�k�Y��MZ��Nx�h�h]=%�m?(�kp�A4�8��m۴LlX:�S�ԂJ��w�D����1��	-l��G9���ö�w�V�-������j�n{bLed<���m�z�왎���7l�+a�'��82�o` �q\�� !-S6�m�h ���P�ޛS����$7t2�1�x�L�~�b�~Z_�h�y�^)�5�oK�B����4��5��U�ů��)=11/J��mw�	��}f�lQ��x����c�qXC��W�P0*�[����v�g�/U/5��N���L,��p�kT���l���vqmj��v��7B� ��Q�.��~�PaՕ4�H3�^���P����˿��順�L��]9�ҺHre�����B-g�WY=Eu/��#���S W��Vn���s�8�/5s�VX� �M4�o�oIRH\�{�%��]h
����_:���TO�c��2d���G�zJ��.3d����rq���N�PVl���q\�:�������,Զ��t�nf����.�D��4��\3
ʑa�ڌe��-���mh�ﲤ&��ŉ款e��{�l�������{ȉY*��E�����Y�b������7yD6�/�J�P��&̱�g�z�&��+Q{�x
�g:��-�
/��uV�'��8%�k��M�k���R��v��a�m��E�6T���tVk�#��]��M�#��D]��<���R�f�>��=o�zk2˫o���I�;�Y�k��
������9�:�ν$e{?�?ۙ�fQ?wLS�.c�'�h�~���s�U�8��}��v�J��D3�-�����a<h�����g��mpJ����>ğk�+��d�p}��Ro Ѫ)q �9��Q�ٽ�3�uɲwwsk�"�7yإlAՒ�ɨ�ξ4����3Ґm��E�xM���~����9qG/�K�푅2�\3���Y��抅�De��I!�r^�O
`uQo�����v�D��YF�[9����!eSOf��ӻ� �8j���'m�kz2G��+r���_�����:XK��ބ}{6��<v��6�'�CG��ư2��8|T]�\�<��E5(z����\5Q��5y6d^�������p���T��^�%ϋ���rM6;:u#�ލ�2^N�-��@�ݎ�Ø��)�lZVE;��$�|@�d<���y��#C~�RV�x��g|�I��e��YI1J��!_ ��� �uD���6���q�Lz�աuw�!-�9/��!#<ݫy��p#�M�U4&�����&�P��_�U �yw<�a,l����E�b����,�-�	˔������8�ۡ�vSq �>�D����xuTWb���F��{E���ԗȂ�U���(;� ��p=n9�:6�V�-����4�RN�N)�Z���٘ȫ3 �t�W
g/z������j_��W4\ӓ�יݬf-����.;z:VKnO�]/f>��2��Ն���r0`4I;�۲<F� ��B�M�m�]�����W���o{�s���|�qY�	��	��V�8�e{��h9ygSD��3
��M�~�>0+ն�{�Y�w�.�l �`#v�@��(Z%GID++�8Ԫ?K=����8�m΍�}3�؜�G����уtFi���rF_�{�����e�3�Ü����4<�B����#ISY����{�������3A`eB�ʁ�#Z��x��C��C�È�vҎ���X��^|͗0?*z������3v�A�{�X� ��E��p�3���^�*�}�-��t��mԀ��qR۪���n��jA6
�$дw��>�¯M���o��%	iN�-0��@"�\�;*+Ţ�]<��ο�'�k�[Y;��r��賊���f%�e��5i�͓mt���H#ie���g*~�p��{��ǉ���j�-z�_���{�u�&.����:Z�]C�8�tnYDZj��ݬ�S��"ymH���������&�ܡ�&�α�u�^�4���+p��7��Wo;�ۡhrc����մ�	.k���ߢ�0��b�8\y�.#���|0��P��xnS]��n�^��x6���IDÌ�1�{�ݰPɸ�-��=W���P�Bj׵�"+[���놸5�̲��Ǩ<: �MG�,W����^�q]Ȇ� .��O;�.l_'Ea\�ϳ���@v�j:��t�ڶ�p�ak*fo��D7)4�9E]r&�,~������V����e��z��.v�a�o?:Q��Sޟ4�^�	H�������PƊ/Q�`MUW���j��3c1�a���HM?�����WTB��IEa=�`u��6�D򩛥P�lК+RH��V���01�:��n���z�Mq�@=΋9���7�8�)I��즡l_�����şu��5��s��e��(��t54`Gny�X�Rٯ��˵��y8����~/�3/P\v�{�R˹83No�Koq�����[ԏ�J��E6�.H@���^��}MS0ߠ@Q��J�᜝eo�ąT�����Jl�����?�c�z�X�%��B6����3f��� >�s��am�G�\��7"���n���i�H6{�j��&��TGu)L�f:�l�#�o'�T��IY-Y8GN���iIc^o�ZɢbǦ�8RnR�U��4����ա��:�k��e�ohy^2ݮ��֧��z��5Qe�<���/�ľ[��h��B��Pma�6����[s�܋-j���6.ͺ�o���
��j�%Q��5���/p9�ⱀ~��/,�߫�9���k5����RR��|���9��I<���Qk$.�ܤ�8)���x��,���#���g�Ž�]%e9�ǰ�@��o�����g��CtM��?�X��tOEe$�,�E��@�Z��K�=����W����rX��ڴ��Z$�Z3P]\먩u����C��wNի�G'M�7��������:-��1�ZU=`�ZI���-E{���zĨ�=˜"f�^e��7���Ǜ���W���M�ʡ�+���f�n?F�]Iz�ޞgN�ul�ڄ��gK?�1�)�B�ڞ��)ԌK�s[5�x���Aֵ�j'<^I�7t������8Oo�פӞǽo�1:^�&��]+��6���!Fy5��Oi�3xXU�j�t��(|�P��Ɲ�ٴ��:�n�)�Av�m 6��(�BV�����c��(��`����ԕ('3`W���E[v����nb�G�FG�v@��ʙ�N��#����t��j�a��*/[k���ba2w�]�ĵ�.��(�v-�c�1,�A�mȋhi;��O4�&[}����3�a���/is�:� ��0�%N[*���Kޅo�*j��N��z�t�Y}�gr��:�1
��jwz�5
1:s� ��ye�"�ʰ
i0.��d�o=��~盝��xu^�k��J�Ͱr#7�=A�O�\�b���g�������Z�2��H���u�}�\寇�72�����ל�=����!���W����)�qN����d֚kd]l����D^ y���;Q�Zi��戛k)����Մ�O+�9�k"^��-���-��M�=����d����h���������;��|#TL���ݱ��������+b2_0��'E�֓Е�,�O�����q��(�6���w�i7�Ro��Ut"?Q�f���ߤ;2+I�g!��㛈:j�W�9�c_��[ŗT�ޗK%=E�L/)2`��;���x�Q~ݣ�tp7�zn��nc�I��=���_�y������G��l�E-�,����H���i6�y���%RW�{f�h��F �g�x�.�گ����0͝�8UC�˙$��x��c�5^�e���E���E A  �K�`vX[�I�%a��
����T!�s�2+ZoI�R���h��������-(�W�ei �v���1�X�ݫ㖨��7b#��~��wf��28���WI\0Pu�!H�'�^��i	���Y�����0�l2��O�'i�&��r�ٳ�e§A��𐎠�D��E����z�%���q���I3j%�Q�<��	�O.d7ꮆ��D~:D��pN�+��֘���.1��֗���p5�(W�LW/��v�FQ�Zf�o�S�m3d�J�d"�@�x������8�����?M� q�p|e�h]���Qx-������]o�|@�������[�h��_���2h�=�#c����ߊ����&)�_L�:�7��|S�[�hR�k9��	��2��lK���� �!]��3�wx�3��|��u�B�-��=�������;^`���.I�P^��$�/Ok�Zݱ�Ԡ]��(ۑmr��q��TI|��j7�N��Է{��_p_FH�Z2nqi����w����+%��ӌh����>�;@މ��t�=qo�eٯ-)_�O��u�0ô��RK??�^����8-��<�Ƨ��
������n�@On��K�w˙��v�][{�iw�S�W�A)S�!ҋހa�G%��Fb�V�������1`CZy�?�J��p�x�ZÛs�n<��-51V�j���Q�;��
r�&��\�]T��b�]C>��z9�3$��QwsX��=�\CSu������l?C�c��osV���gEG�?]n�D3|}<���k���P����P5��ȃ�.���)Fu��z0)c�Ϩ�����Vw�
gM(L%j!�Ⱦ���|�˞�RI�;M]i:ܒ���mvN��R�(QB�xX�kTBX�7���50h˜�|7(eXWp�>�j� �C��T�+G�Ծw������,��J����p�(�ӻMb�K��XfOT��z-�
&�*����`T��~u2k�Ĭ���Վ��]M��S�'GOdg�A�b�~%�F��t�oeŬ���P�d�0=�$�ڍ�I]&�q�^^���Qũ#f�U���RPO^V���0�ʪ��2�1)x ��.����־:���pm�k���Gt��Í��A�E~@Ѐ.#u��ΰ�^z�G3�:j���֎=�8ʳ�l���j���Z����<W��}S�Lc�8*4z:.��I3�?���7zd�E�v��{bi��<>���_�j�(���j,�2d+1������B�g�	W�1I �I��fWi��P"���!��P&���8��Ag@�6_\�o�mp��Z�g��F*5���� Ð,�3��A��i����@OQ:���f��=�}�(��R��T�Dg`82�)6�� �@�׫P` ��f��~�Z�u�:�$��@[��:���[ )���b��Ža��"5T��w�4C�f�AG}�R/�L��ǅ�K �7VCr^���!�jЦ\�!�\���Wjn�B^��v�-�L�mB/�����/���BJ���LlT�Z�7'Bw>ɠ�	҇B/~�}>9��_��;�<��D�O����w�������t      
      x������ � �           x�e��j1E�{��} ��h_��^��9�Icb��&���g$p��s�z�@ T����1���:l1bd�5���Ra�E�Ŗ��>9Ä�)5�8�QJ��z:/?�GS:$q(=�:�
�v���߄*�%T�*��W	5`�*S��~�XDm|Q�"j�;Q;o���}�XD��r[�����4����s�sh��)�߬�"Z�O�"�_3IE�6_LE�;qh=v�0Tؙ� 3�1�`Hߧ���Z.+������
ߞI���d         �   x�3���ON�Q�M,�N-)�|�c�K���`ǔ;�?���`��;���`ǖ;;옩��`g3�~�c������`gH��\F��9�I���f7M i����d�����淃m�FM�=... }0b<         �   x�3�t���M,.�|�c�K���`ǔ;�?ر,2���`�-v�z������`م`r)�Ȁ���4v6�o������`�<�,Мv$s����2����Z�^�����`m�`��X���qqq ��G         �   x�3���ON�Q�M,�N-)�|�c�K���`ǔ;�?���`��;���`ǖ;;옩��`g3�~�c������`gH��\F��9�I���f7M i����d�����淃m�FM�=... }0b<         �   x�}�M�0���)z#��$�A�B�l�fb������-%�@��|o�M���5�����qM�Ȃ"!4!�l�S����D����;뷆�:�UV����T$E{�Hs��f|���Q��5%ײQ'��$ylvvp�k^!k�3������ܘz�>�qc?8½�o����r�1?�)p���+��'�fY�^,� ��L��         �   x�}NA
1<���œ쒦�mw��cD����
��b��<Ŷ,x�$f��+@ �=D�1��܂�`F}{ $n�7�-46A��Rٕ�fM[���[�^�r�*��U�Y����*G�xe���M�i*�"�N|kx�<r)�#^���U�ͦ5�| �c�         2   x�3�t*��|������vv>ر�ˈ385'(��`Ǧ;q��qqq ��{         �   x�}NA
�0<o^ы'i�l�6�[|�H�xT��E7������'݁�Yf�R [�$�e�r�(27���-�I�gxj=IlIXBͮ��X;&�	����N�z������\AG�����Y���ʆU�g�ܠw��X��;��*C��ȭ�q���W�3����d         k   x�3���SH*���|������v4>ر���v.#�LqnbN�BRbz1���XFv� +�7<ر
�c؀�v������f�������v�>������� 	RY�         �   x����
�@�뻧��4�&�@,�6�6��(H���^�ة� X(����G�"i���|31��@�8V�LC_i�4�k�B�'|7�OV�w�6> �>����S �Wi��S`;U NЭ��[iAK��� L)O9�Lx+bĉ�����cˢy�l3��G��(K��b
Q��ϖ*^ɶ����FܾUK+�f����*�h.�����
s�4      !   *   x�3�4�4�2�4�Ɯ�@҄�H�r�I3��W� f��      #   �   x�u��jA��٧�'�ŋ�c��ܥL3���Y��Hm��B
����f%{cc�6������n��9�90-��2�q�δf:0�0�D�D��%�q�b��NO7��A�.=�ʹaZ1͘>�~��\���=��P���TX!b)M
�k��FWb��)���@�Ρ��C�V�Rz�s����Sla_��2}˹�B�!�s�$��_i,/:2�д��N�s��#���'�(I�ÅR��O
�      %   {   x�3�t���M,.�|�c����`Ǵ;v<�1���-v�z������`م`r)�HSZijP�����vv>ر̝T�ێ�w����R\� ��y�E镜0��J��*fb����� �Ej�      '   ,  x��SMo�@=���p�8�=T>$��pq�%Z��z���HI�8�B�*�FQ�U%R�X���)̌Ԫ�,k�~���7;�� �c��Gi����Vi�:k�Zsd�w[�L�0�\��}F��5C[��b͹5]��Ł5֔���YA�4�It̠���0����܃����"̄��j�w�$a�iu��q�X�o�	��ZS�0=c4�5��d(}��]V��a)��'���5?m՟��jQ#�W�{DW`S?V�P�&ք��H����Ѝ�k�+A�K⥔���������j+���Ξ�.r���xˌ�C��`C�0'���]��6"`��;������st�
U.�e��,U�&&�F��V"�E.iv��8�cf�;��`�0�{ވ���Zh�侖��%���(���\4}Ƅ�z�[�|��h�w<!�.�F�5x�g"�3"|��hAI�� �gM}��:Xߧ�\��p<�ʝ\��`$�)��q6q��EXЬм��p6��7P��349�!kP��*�HӰs�[��?����;�����&s      )   @
  x��YKo�H>�~��avD�u�8���L&�70��ܑS�����c�;s�8Y�A��`xǆI��P��?e���dӢ$c�E쮮��W_���v]n���it�Y���/��s��e]ӗ�8�G�q�/z��X��;qt�_.�
3k�(�U��}��s�|]�,�GG�2�D�.���8:���$��~�e&k���4s\��W�t�})зZe��c��� ]����oqtE�.�9��b�(�P��{���۸v�G[�Ը �M��ڸr �>wD~5�����O7�ev���5ö��Û�_��R㝒B�q�~G���(U[���K%�(���R������9#�K�dJ%��,��o�ß��t�����"�rxm�_��%�8!Mߒ@��!8 5���(7��n[h��EMr��l�zn�	�U������ނ@x�����0�wt�I��TŞ׷����D������4�*-v7�m��ȋ��m?�Z�=�CKxF�Ɍ^���Bч�<��;��_��j��ܶE�3�{����?"��O��v� ���R��b�7�4�{������o,ܻM�}Fw<%�>�ǯ�������&<G؆�6��+�2nR	S��r���`y���)*jC8��#:��NY^��/t�h-��p��j�-{B8ENO8L��r�?�p��1`�z�U��1<���1�n����=8N !���������ͪ�����bK�LN]��
0��t�v~$��T����� t�xbCx�
�p�g��)G�d��N���riҗ���7�c��If��C=c�
��qmFz^���*d�mgzj|�dE��p�3��}B?�+P�O�9���g��DPṝ^}��:[q�^?h��H�}P�hw��[	{��B)���<��T�+[��Aa�P� ^3�2��^P���s!�'n��^QQ(� 0~�/�y��u;��}Y�s�ä|Oy9[b�Bo2�I{h�-���L��M�<G�lG��׶�u(q4֐%ϖJ�-�v5QAv��ң�50���h�]K�¾A ^+��ϳm���ý�W_M��:�|xS���>&�����?���O�Y rh#2ӚOȎ��z��v��&Lw ��l��Q����phO���)>9�]�hHX��K(*t��hj�QYd��
�X���{��KU��P�>��׬��>_��k;P�#}U�7l�h��j�g}�Z�4��Uj�j�g��U)eM3�1����
��S������<ηy�g
��ǨZV.C:p��K9�*:���\�\��}t��2��D�Lc�t��U������ڝƜ~�Zb]���+��T��"�^S�UJ��
��ȥC�V�ΟrLV9�r9�D�8.8��)&x�jPOɸp{-WFo�V���n��I�"{��
�SR{L��$@wF��$Ғ�7���a d�;�a����� �D�uN4$�b�"�W���*��)��;�ǱdoIO�`�Y>ԧ p)�Q�]�Qb�]�m�*z�j�mכey���Q�)�u��C�c���tމ��H_�;�.m�^��ߴLn ����._I>�(̻"�h
KI#��d����pO,�4��ppaAG�®�!�`�,W)�i/[���E�+Hl��Oi�&Zi4L	l��)5�l%|P(b�D�w����ˬ��dO����~��j���I?H�)uy0{c=m�]�Α�۸�� 1�<F�w-�b��@�ߓ��Nn�g�m�:\*r���
[�)�Fe�)^�B6�4���S�<t����r!+C��-���a��7���@�)�6�^���>S�t�VB[U)6��@�9��y
�q��a�b�W\�ޠDR,5�	�5�0���P0�e.7�Jn��{�d�P� p���p�!kX��Fez�fs������M����i����k��W_�m�*��Z'�)VY'ȷ8{S���P��6�4Q`[�7��(E��!T���@Za�?�A�q�X澱��Ѳ�e��j�,< �.�H��\���8��bO�N+ʬ�@��{�֟u&�7���w�9�XS$U#P��N���ȳ��ݖ�KmސZ�es�Ή�r;�Y3BvK�:[~�����8(��j(�\S#�,�~�(�Row(]~��� BӴa�~Q�� ��)L��`�\�W�z�n���@)�%_F����BHZ�l���!o�}T�����m�}ǝ���N�������?Li!\~	�ڮou��/h�i&��������my�ޡ���$A�jǅ��d�3U/'_m��w��r�t� �E��q�L>PcI�i %z�U@�U��=.���-:~�&�Moh&��Ģ��1�64��>�Ådg?E9���ל����2��H�T�tA:���
�u�Ҭ����>��e&��۪>�]I.�V�=��Ry�e,<-��Fʼԟ�^&^�e�Z��4�3q����kP�vK�#KA�		�X�ɑ�b\��e�*�!k�Q�&s����(%i	'�$Ԩo9�(MN�`���Ή�GH��-�I���B�3�������≧"��*o�+�Eu.A�vY�Գe��Q�ݣ��VY���@酪�i�yI���P�����qLbџ�T*��5��I      +      x������ � �      -   {  x�mV�NW��b�����eRE��,�zs�Z�FfWw�F�k5U�@񂄂�q��8P��>Jg�9^bn,�������L^�h/쇐��L�dZgz�-~��y��2}��ϙ�g:��;@	J��Z	:���^{�B�񌡚��K����Y6�Q쫝d ������ţV��b?�y[��z�8�^&�������P�ߏ�N�8Jbts������ud�/�*�_2=�G'�en����h=��= �b���-����K��-{ZI�� � ��?�9[���	��*�Db�3}�q����b���@J8��V�*�1,�u=�s��A�`S�L�CS����L!�z6�V�f��p�gB�S��JyR��Q}�J�kc[�;�� ����K�Qk�=L����[�ޛZb��R&��Z���UsqL�]`|w�dS��T�_=�ׄ4�'��s(��"G��c��{�N��.B�VR� ����P��G�w�܎�3))f�I�e��q��VQ_�����>'-k[��a?�́=aҴEpc�#u�z���c��ރ QX�H�H5@� �JSF�HR~/Vu$!�V=��'�C)5D���g������g�^�v���]�l��.���cY�I����"��E�S��h"ma9�	񝡝 K��P���g^�9;3SL�Ť���{�N��<�(PCҙV��������[O���%��U$�:	M�glt���X���B�^��W��Z��$���"��p̥�K���2'���+[�1�xʳ��_c��h�M@ �"�^_1�R��x����(�vc�w��uٌ�S�~���c�%^,]`��"q�Tp�q���./�=}�|�y�������3i[-N\C�t��W�Er�.��Oï�a����Qom��Y3ʍefj�mC�� �E�++��D�a/M��C�*n+ef��&ۿZ�-��@�T��4�0��Ȇ����_�A|��d�����S�?���r�W˄��;�Hz�"�Vui*��r!�TY��2U�`��]�nn�V�M����	�h�=G�>gQ�2`A�ܱ��|�0Vw|��d�s��,���,-�i/�NN����̝܉W+�r/D��5����Y��,� X����k%��u��3�U�2��RN����==ʦ;�CdB��O�ay"�{=eΑ��o"u�vm��y'(�W�;��u�Hڷ:8I�{�¼�BI��w����^�f'Ӥ>5�s�sΤ��,�'Ⳗ�a�?�좑��LP�����D%��csͪ�W }4���(K'�*g��[��Dw�?�;F��Iw������<������Ə�y�o�}�k��9�L��R���[i�)ބu~g����x�Ѱj1����q�vEڕ��wkkk����-      /   J  x�MWY�e!�>.�K�q/��ut�t��}$P���o�OW�	w;	O����~�=����4� z��6$�kC���$�c�; v8��l��{���D,��4��K`���e4���,����������_�۴|M�w��P�j@m:qN�u%�6q~\��#�hjb,���1�F�8,=�wӛx"�+��d[����N��<��>o�?'澸׉|�0b�.I,m�a�w1���J��ډp�"p�N< �����Gbi[{����4�+1<����j�hx\#��K;ݰ{�}���$�@hbuf�/'V�at������&��3�/�kx�a�<�$�v�px0�L�e�=vbx����ً�1��K���^|~ÃCƉ3���px0�N�c�=nbx<��1z�0S8	�C�)/�e���>��W��"�=�����`���Ӄ�%qi��&l�&	1�	�̈́�YA�,g^��1�����I0���F���1��X�C��!B|P9�g7I�ơ23CŐ�C%��Q)+1� �Mx3T���:��8��*�"g\ȋ��r��}����7���
�D=.��)\��Q�ī3������Ib��Al&��D��eY$i1�N��rZ.�0�	�n��Q�p�/��#��}M�٧��LqZIZ�[Y�GY.%R�ځDjP;$�HZpH�,J�\��e��_�:6(ުc��!��<��@��hHZ�ҧ,J�4P��;UT��|�w�8Ɵ呄��*7��+߫8P�Wq� OKA�%�e�$�٧ -&Viy��<Wp�pګ�(�G|K�Q=�\����Ht2���E��2�h1cc� �[�
�Cf����D����-��Ąu��*���8���#�_o�TJ��ΑWR:s�qf�	��	�3�L8��,�$-v`l^�3�e�$��U�P�F��J�͎<&^��e�^˲��3�x3�Il��l�э��&/vS�؍Gs�2��eq_]N6ɜNp�,�$-�M$�ěH�Ȫ8(sUT�^Y���bޞ� �ݳlJ��$�ɠ�$�b� ;q���y�p�EPh�E1{�GE�>p쵉G,:$��?N���w=��J�#	zxK.��3I�!�$a7o�7�5x�y��A��a<Ւ�S]a<u��:@
��n�$w;V��@�̻�0��Ga$� ��#2�0�D��Z���0���@A"�A�0ޚ7�-�0��#B����n���8�6�0�jc� ��J�0�W�=�M!�/�V�ˬ��2��q��5����׫�ui�$R�c,m��D+�s���MP���e�c5�Fٙ�m��Ok���E=      1   �   x�3���/*�H-��|�c����hy������v�|�c��k9����8�S�J�s���h|�c)��Vc5+��ռS���`��;6�M]F�`{:���`�"�ج5�O%d��Vl��J��`�f����~o���	V���� {^�x      3   4  x��SMo�0>ۿ"�i d|\!m0�I\�x��,R;�I�q��R��c�6!�j�h5��ο�O�~�D-�IHQb�~?��� ݓ�%����S�FOܺxg�xm��$#<�)�F�2E��c��F�6�e�w��Z&6���w�h�|�}���S��'F��Z\��m�7�;x=M*y��$��1��5ɘ�eG� c���ǅ��:zěTebF���A���m�B��G"ᑷKx�{l��vU}(����(�t�w��)�� �s|=�z�����ѧ.^����&pj#?!a�� mK��ղ^���X[�8XAO��_!�{�{ Xl���B�c�	��I"��)�3��`���:zFTF�T��*%��l��Jj�>�;: 5����k�S���q��xn���Y�$�T��	[׃!5k����C�݆x��5��q5��)���&z���?���B�3I�l�R�֍��tm � � �a�Xwn`]2�J��fH;pԭ��6�1S���l��z��J��|����j��)�Q�UJCgLk����%������/<�l�      5      x������ � �      7      x������ � �      9   �  x���MO�0�����i���3ɱ��-�D���� "��I���N�*vq"TE}���=�ǥh�?�"�E)�]7�zcJ��uF�`T��	.�*����<V=xc���TD=���(z��q&z�ah��3&'���c�Z�&� ��1�7�����b��C9b!�1��!1�!C2��(�H���l�Fq�A�͓*:�0\9�塺	>(UM�Ay�fBʃ�Q��P�D<��P�D2����C�j�ߖ���e��@��Y�-�%45vۅy�YK�N���EU��AӀջ�$<����bk�����NzST�n�V����yw}��I��oLM��L���.�$�n�99��[�9�8 v׬<�b�2���A~�wձ�'7m���;�-��h��u���ȋ�g��`ݘ�e��Ӫ��U�xR3���r��}Nc�S#��D\P�&�:�*�34E���5��ʶ@O��ʬ��5�H��]�K2Ӷ����9�)z�f��ja�zQ�+�v/���$iD��DN�(���>'*f�����p�ņ���[�#p�+���i�k��4�? �;(�r�T,������_�J�C�?�f��RD�xT��إ���dQ����&y����R�ZWo�'I�tS�lc��%A?@7��}�b_2�*,�W��5�s�1�l�f~      ;   �   x�M��J1��gF���MH�lVvS�w���p)�U+�O��m�Gq3]������'�d��E�,!?�� y�|B�!�[�"3����u�y�$�o�-B,��m�N��Pϝ�W�Ѩ�����L����.�M��>��c���I^�jޣPD����i��4��t	������}*ʞ+I-�]�n�M�r�%�T��:7þq�ɵF��Y?]�ҠR���!�3�ꑣm0�"��m      =   �  x���Y�� D��Sp�������̈́���o�Y���c>-^f-$�I��$ލ��!a�h'"���)t���u�Վ�`x�h�4ge���uWc����Dӥ%���v�t�'?���ش�ϣ'M�X�m����(��b��h�f7A�ŧ��wAxbdt�ﴀGq�z��Y \�(���D�z�[��%�����i���r�����щ�Qvб�[wK��@U+�w���hQ6�YR,��9k����GM��Ds���k�ˑ�#[&��:C�� U�*�02�M�9�5���GlYA�%�.潤e�돃��س1.lZ�m�=�#��w ���f�������)uU6?P��CPU�ݭ��1�b�bE}T�^��'�S���H��7���p'm�G!kI��B�ͯ&��qd���+d�`���]�1E�<��f�I�^1�� 6������|kBৠ�Rn�՟C�ܿm�D��K�U4���L���-����R��s�;a�>�4�Sͼ      ?   �  x��V�N#G}��
A������x�=����&H�(�M�]mdB	BZ.+�3����i��ȋ5�{�:�N ���c^Dc��u�G]�1�����Y�" �3���Co�beJ���^�բ�Vuu]W��y]]�룺�T�[��bx�d� &��3�!��7
\��	����r��-��k�������>�TWh�<M�dF^��"�7����^�S ���y`�>�"�X�qI9�|�#�$ٸI��/��+C��(�%�>����`�ԕ�Ԯ�Z\���d�NIpщd!�ao�z��n�{�nIZ��4�#��I]ݑ�d�T�[�wG��J\�����G5�F^��rPPND65�<�Q] �wa����s����il��B1�C�	/c��iERW�#���V�Ǎ����d�����y������$�����ܣ���>�E>*��fg��o��h
�6g[J+VY��� 9��뮸��U���_��aӸ�w�`��O�v`�$22��Pv.���������"�'�ƦeI�6�T��܃HfI��.hT���P<�H7#�<��j�Dn��D?�"3NW��k}�0y��UL�C �|x���7<4�E�m&�"Ǌ��h�q;f�����nr�F2�B��s��(�u�ό�sU.��<ޘI�8�V^$�4�=WI��(��l�� =s<T�X�x{���K�e��VfQ^�-������
O���Y�3�8��w]W�R�g�W���wRn5�� Z����S�Y�T���;r]Q����w�Zro�b�Zs�gᶘ�T	���Ky��h�!�\��S��ݪ�Ⴙ$�Igl��c��N�1݅��������HÆ��a�G̵p��1����Z�:�Hʢ�L��Ѱ=0��,m��.c�s��:�=R�C��D�Ϛ3��'j#��%���Ϫ��i9�E�mL~VY�q���dg���E\���A�NJ�w�A��Z�<%~��b���V,kbxD�5UuNV��<��Bʅ�vL�jzȼ!��
��&B]�+�������t�t7��WjQ6{�=�[J"�IB]�Յ��~W�Vr�Hm�n�O%�2���1_Ux�<l>6���¥��O���3�yh��zj��0?�<��ӆg� �m��7׾?�\l�֞[�wYG*����=X����(������"��S��y��f9p���)2ta^NU�l\(e�5�~�<P`�z�����M�����Dj<�rxIZ���LL�      A      x������ � �      C      x����nTY�6z��S�R��"֊��$��Z�����8�C �ʻ��jH���ޝ&)C]��r�i��	����G�s�7�
�J�t�+�a�1��c�ŵ����_�����og����og�����v�����og{EY������*�y���4#�u�"��ζ~;;3ك��ޡ`��6}:][�=y:��#F���>�����+�
�5Z�7]{���>��y������m��)�H]�{-\��[�5Z-�m�ii�4�sa���<�c���!Wz�w�!\�/��F����+�ӿ�G���;�_�����b� ���a^�t��l<
�c�!?�s{�o���������w��_f.3���=
�QFn�#��r�G+����S�ߗ�s����l�~�lǑe�x@��l}�8��;K����=}懔��W�Mys���e���/����Ɇ_f^�k�R�Ɵ�hŢ�%�z};BAy�=�r���e��>{¿��K�/����K�^qo��p4^��p{�,����ϛ|�MX�����uqo�r��ps��Hď�\~�o�o�4
6����i������&�&�]������r�y}�k}�W釗��Y��|;�z�&o�}���FlF�A���6O�����!�g��^݀��;,����_\�������G��?o��&�ؿ�Js\p� �q[��6--Z���M;���w�^x�tU,��6�f�a��ܴ����:���"ۏR��&/��2}���'��_xqm�K��=FߟN6&��~ɷx�o�%+������mzo_��Pؽ�;�-}���hλ�]e��=��~��R�^��76�F��|���_���謽(;��~��0�qz�����vA���턕�>�v�T��1o�^	����zJ�%��˵ٓ�l��m���8�M,���*��vpd*�&᥌�G^���:�W�,B�ō�(�c}�����ݜ�+l���-g:B����V�n�����j�Yk�H�L�|�G�T�iS�o�m�;�����
$��݈�w�n����v��@�|OV8=����o�
7��_�??��!���Fى-���Q1ؒ�ю���>Z��%��N8D���O��`��ZV��V%>]]�6�~�	�,����q�����q�9���J}�o�-kď��v��c�/ғ]�t�����7n�.nM�褛�n�do�LUn8�2.�N��Z8����i%V���}W�#~Qb�d����{�s��ò�EEM�u�N�Y�j����vuk�:��"=g0�x�m��|�k͑uGt��(�'SWwo�Zx�/�$� �����#ӏbUl�Q�!��܏��;�M~m^�+��w8����)i��g$\�θ���H��t�	�bIz7���.S�a������v��:��X�]]c5��t_AGm������?':1
���=�d�خ�- '�o�ɘ̆I��}���''��#�P^����]9W}웕�?����L�j;ŵ����heZ�6ئ���>\Y\�"�2���e���|�V�Tō	�˳?���6�3�?�[�2]���f^�p@J/�z�"�,�̲7�����5����JfQn�?m�����r}�ʈ�����OE���ڋ���'�����=�O�Sm�|ë��|�.͐��Ix�꼼��r�w�����`��/��򼥣kDJ�����g��$;Ou�_���C�_����� �h�S^���T�=^�(`���aڵ ����7�s��#O�V��W�x~����]��.K��wl�ټi�h5:J�~�Bc�*�~�� �7�oU��h��7�e����&�S�����7Ξ��O����l�_��j�MvСm4�Ƒ�#5lMr�U���h�C:n�Z�sEgd��W��o�e6�����U�;�.D���k0E��l�M�ʹ��B��v�:�hx��
P>F��d��i�ǻ�ע�s�����mP��`ۆ;�7����vL��W0d���F���1���Î��1��MvpT:(���dQ��m0��K��R���Ar:�����ED�9^���(y	��6�kG\���HC�Q��(d��ھ�p�o�Br�~�����³>��7Z����?�m���W	}R����G��@�ư2ƫ��H��K�kࡃ���COs��ӳx�t0*�;�����z�JhSτ�,��Gev ��FE;�Q��H���.�k�0��O���荢�u�CH���1�ֳ����QyZ:u]�I���n3�����������F�ϱ��Q�+��n8:԰�6P\(3o����e�M���j�V7=���S��O�]337�CD��?�3�N�����ͻ��ǃ#����oE5P��f���=s��,J�Y#��.JV�C~Oi����횉x�X���f���~ ��Z�N�%�T�����������+�B�����d���3��ܐ��Ga�=i�g�G�2FQ��.���]O�9�-�So�'O�vh�����l�9XtK{u���i0�Ɖͱ��eS�O��(&1Y1��q�q���<b�-�(�W����*K��=D�`r}_tI�U5������D��Z�`{�{�-�`s�9��x�<��"�q��e���m�emX�h=��H�"���hƎ3��^r2o������a�pN#�`��h�l��3ė	^r��?Y]���t�H��+S�x�V��Qvi2�k�i���颸��[����8sD�ֶ��m�� �O��E�	�n�z�� ��Aqk��<z¨=S&���x�Ά�Т�w(^O�a��>��W ��D�1�P$Pe��R޲q~���
�œFE~�oW���G�K�p�
5Y�'�R��NPx��+����i�%��EmO3|/�u�n��-�^�����n�x�&���x��-�9&u�c6Woa�;Z� :�ج�H��-[�杙B�1K�R�'z[���ɗC��B�+mpof��S�ǅ���w�z������}y]�E��0Y��?.�~$��%F��A��pL�&/?VӋ����\�^�um�֔�}|�����Uk잕Ί(Mϡ���G�w�5SZ ��T5?��h�9|G~�Ez��'j��#lگ�؋��e"���a�2R@�R���� <�/���[/�E��=Q�.�M.�q���̮����ě���U_��eCK�cۣ��ѓ��"����l����[~�/z�y�go�N�&�X?���'����_�B����М�f��iq��$�I��!Z�ǵ4�a�Uݱì߹4.P�;����p�Cn
$*��M7_*�Y�,ȿ>m���L~�\�ď|C�-�je7��9�1 ��=���q^b����|\���I�GN
q=N񊃈�i�ϻ�!��4���������77`{aB�\"K��V��5��A�p}S�Eι�� �ǔ�^. 7w��kzJ����M��V�����d�פ�kڴ��6MW�x���=0ѬJ���V@2Fn'�u�6&�i)F)w������� mŁ��'�S�a�!���%����)�r�e��؏��|<�u_��𞢸8>�����Ok~ϗx�,��� ��h���l�bAp>������G^`Q�v��(�Ň�F"P�w�9���曘�|S�s���Oc0녅BD��G��Łؚ�]L�Q#�H	��ܛ������ӭ%�}�\bMcD���Q�4�fg -�;U{/�y��ϼ��%J��C�(Ե���G�4u����6�0"G��^.����3�E�$ז�u5�v��Һ�&oz?�$U�o�8W���^\����������J�l�(QS�B�no�綜+�ռO�z��daRe�:y�ba�͐����.��޿�o���?�2��.D�^��������%ɞ�ذ�9�ɷh� �a��k�&s�W����1�8�r����_Q52-���Ǳ����4�N*
N���Ö�o|��q��p���4̮$��+%�֯������Opv�0V���m*�,K� *�s�
��1��d��s���F��(���ޤm�Z�e�F�F���3��a}	�=�~�ԏٓ���U�o��#Jp    XI��G�@��qGk�<�&|�����R�f��^�-<Ȍ"�h~g~��EQ����~�Y�M{�Q���Q΂�>�{���M�A�W�_��CyO9>{i����]]�Y�XP+b%?*@��O"�/.��^�)��J)7�!:���3�f�q>$4��~��|ȟ:�飘Tf�n�e-$�����V�e���v�}���u���h�jԸC�C�f�M{=�6R�-��Cr%�5q��M��ۖ��<"����	��� m��6	��
�=l��f@p\	�����o��{L�C%&�S�\xk|��Hh 4�w֦7I�*is׎�}v��{oJ��I����h0 g�=�n?MR#?�i�Y��xÙk�����;$��ӅR}��|�DG	@�o���F����(�t.��ME��eL�'F���_#���<���~D�6�ҡ`[�g�t�s�ث���oLs"ؖ�8�Q³|fNf�0*A�]w����7�<��i�^�;�4�|������,h���-�u�2��WU���R�+��>F��|8r���v�	���a���,��ms��b�As~�!2���N��x���S��"�����#���f�?a� o���7sȕ;�i"8fh��[��{�Jn�Ҽ3�������I�m��z��s��t@����л��^��#��9�V��)�w�ok��"i�K�ѫ{�^�N��M$/�|y�|Ȣ�kū9�n�Q�wj�؃o�)�"B=�v[�x7#�԰��vL�5HD������+>�+,h�O�;	��n�"0���i�%�������S�2��څ"�(Q���Ɇ���a�a����J�!;lb�"/��k�`��>QD�b�X�<!QD�vd~����{�q,��GRx`8�
���\ჼ���OPCM�2g_ Y*2��U����y�FR�T*�8ҕ�"���b�"ʵ���}w��KXA�$s��M*/��_ ��Fѳ�`#����z��5��Z�6�KuV����8���0Ѩ�y���(�u1���9�TZv��ps�j1o�����0��lI�[�hը��� Y�ej�����[��M�af�Op�l�rƅ�K�I���Ӡ6s�I����n�a�ȼ6�6�~��v�y�tcv�J��k�#W�Ep�0Z���XU �����ɟ�w:���"�l�a��-ۊ/҅�|�U=�뼨��	�\�-)�b� 
xd�uʇ�b*1f��ͧ-N��H�YBy�.�޳R�Фb� �F5I�mZ�� s�Ҩ\����$T�� ����܆�E�Z�mKԑ]����T�h�25s�(l�4o �g�V���6U�J�bk�bu�i�i����K��,�h�Mqc�&	�w@��\$��ō)E6���%Sr'�1���(7�ݻS�����	�m�:���ވv� ��K�Z�u�E�G(Yb��s2�=�Ud�-+e1#��;�)� �%��.�����\���"���\ �Z�F+C>55*�*�&�����u�Yת���a��	��Zx�B�'�̀���7@s�%�v�1����r+ե��jh>J�p6�;�����ly=���Yufo
_i-%��g�Ǝ=Er7�lhm��[t�|�q�jx\�UJ��)�X�1�{lY@v%$�u�2q���S"���t�wkż�X ��i�)7�,X�Fp1^�f���c�8��7L]q�ͿXn ������#��l%$<+�8�z+� hW�#�V��ӱ�g|��'�6~���Z	x�Y�8��r��G	m�90�"�M�;�VSZ����LDʹ��y�(B<���M���8Ḛ�^%�q�AI�q��DkW&-_��(P��U��/]h� �JغR���x�Vn
����@�X�������tս��)���o�U\�_�iH���~���ϮlIE@Ԯl�}�7�L#޹�+��7���ԽV֕�l �^Lu)'P���
%�B�=��%�j�r�gE�*"y��M��=�KR�hJ2�b|�d����4]ՠ�jyi<�<����\(��� ��4�^f��4����]u���h�GM��[�FN��򇋭�P���hdtHX���b�u/����D*��ibUˀ��0�/w):�n��"(�{Q���s�48w�
��+��Dq�%���X4�H���J������F
�K��2%bE�����(���)��H�[K��S���a���6�}� ؽ<V������(����Q�+�1���^[��)�o���t`Þvp �~X|�|i����5"^2�#F,�#D/�F(1��r3HP;��p�`G?�R��s���j���g��*�g�J����Ĥ�O�]i�iN�U�\M;���r0� 9�m ��JgW�˩s�I#BKg^�ƥ���,8�d�ko�c(V�;�S+#I�>��g�X���ԓt�"��кPΒ7�o���P�;�[���g'_`@�B*�m��FU���o�1a3�S*����p�f0gY�is(���������t�U̿do`m��dW�V���^U@����9\[�+�� ����A���-�-���g���I͜4>t3)��9"{�X�Y_%�
��8���p��F_��+}�cfEMo��"�/
�p���A�KD�!���x���)��F�oG�<�נ! (<��^��#�ի-JUl���1m{�1�Ҷ~�R�ec�N�3vG�3w,��S�V�źp{�*���X.{�i
*��ݚc!a}=���
����>��^�������R �#�z-�E��	��A���[C�*��b��xN�T����ٗ����Y����^�-��R���c��V���`����s��v�<c"�'���Gcd�zNΉ)�;��_I�U�z�0m�>`�m�ss׀��د�#�����i���Rx�Gh��0���&��mSJ����aN���=��=Fl����Tx&�����9��N0 �h5� ����ÑQ&w��t�|���H��u��ɸN�5	��`�)x`z�!n����1J�=J7���?�	 DB�17�� q�,D�����[�U,#
`�s>12�{o��.愿���2�cZi�
��F�WH��K�c�ax;+1I�ulW�Ap�t��<��|��"���D�S3��zڻ��%����x�y�pB�O�(@uk���籵�~g���)D^�����K��܉d�1�xPr4�c��)�D�A��ᢏű¤�{�� -�{����Gq��;75�Z+k�^=�sќ ������� a���,��E�>�+�&/@���Z���ƀb,�C࿳_
Zb_��=b�����4�ވM�����W�T��s�86�h�9m���d��Fp�g̭"�5h�q.��=��F���j�dd�Ӷ���5���XC�J�姹�����@��&<��'p�]Qfȇ�����,�#�N���V���G���ҍ5�TCϒG�;�[[=�h�v��Rc�1�8��2}�k�
�Z'�E(ӓT��W} ���l�HL��:�;�RJ�(៽+�|����b�a�>aGE�I�j�B�R���b�3/�شSa��n���]4��)픉��n�,���P���4��e��j��V{��q:��'�J�ܘ��w��^#��7���@��؈*��j4�W�b"�/�������=��+�����f=�"������P7�EE��{��3��pE»�f���WN�~;���_2�U�̍���j�3��3��[��RjO�;�}!�3B[K0Zۀ�|Dh��+0�-���y<A�"���� ���;+��Tm�.��0�����"�z���ގ��ֹaeas@
"�����1 Ɂ�l<V���N��P�yl��I'x�� /�kvT�O�Cy��4b�+|N�;Qw��k�U/���r������U��vI`NO��@]4]Z,�]8�\��U�7���F�b�ܘ xW.x�[�դB׮I R�y|�y! ��e�@ p�t1�#�#�o���������>    )�	�^�~��%  4�ȸ�o�#������(N��Pm�ǿ��"1x$�[����,�]�b��誄��(�fl��q�J�:���:�Ɠ���7�6�.3u�e.���ޣ��({��u�h	l�9ű�W`�F|_�S�2��}��|�Im��:B�0�j�����t� ���5�)�����u;("K͟>!���/�S�l�n��k�?�S��Ŷ�c#0|�u2̵��K����W��A�v��2��s�.�X���I$��(����E!D82V�GO&F�9H�k��О��4�R���1 06F����/v���Gtl�s�S$��痹�-�Y_F�vt�pC���k��S�E���{3��$t�=�\�W�N��Sw�p�6)@X��qx�>Z�i{9o\���=ix�rL��N>�1��Y�f�Jݠ ���m�>�}�t��o�׻Z�P��&�|�?�;!M�"-:-��d,�'��NY��-�(HN!MS#��h�_�%y�-��r�V~f�j������+X�� hCz������������N�-�95`�����W?]���Vor?��<$��)�\���,w�ВڐbA��5hU��He��֊��b���_��;�s-��f�>��D���:���}$�#Ú���������vOQ�����������L"ݏ�J��*Ѝ42>U��!�Z�Â#��'���V+�E��H�� :W���nI�%%Q���b<��w̌��+0M��l�gޝZ��gI0��_v�B���+���ny�v�%h�GA���&��??O� ٨�'�&���|�R^'��C�r����Y�]������ I�Չz��l�a�]��Q��9Å���)���Fk�X�x%+eYkw�Fs2ɰ�p�P��pʳ��i<�1��B���8Sh�1�Gw��1�,�0�=&���&(T�F4:�+�?Xi��j�l8l*�d�f�d@�%�$la>vb���Y,� r��ӊGeF)?��5cRz�S�a¿�'��9�޽�&%jA�J�.5eJ��i�[M)�ЀD�)Mn���+Q!ʚ����u��b�aW}�������	�~Cp庐��L�"2�c3���}F��Z��L��kQe��q��S֚&��D��ýf����/@z L��Y{����V@���Nc���ʁ-�=[*/��Qu��2C��fEsﶙ�C�-(�`dJ���+&>�������1 �C��v�Z��
p�[K��������s�ʘ�_<KT���p��
�d��\�:�?LZ�#5 ����qM�@p*X/eM>d�ꔸ{�Q_��Pwl���Z�ʂD[iz���Ćb��<M��4SfF�vV3Kƛ���$"Y�_?n�cX��.es`��ߛ�s��D�Q��9ۀ��@� Nk���.����%�r�TNx��,��Q�Oj�<�u�J�J��@Kd�%��vjm[{�hmo�vx�xo�8�����3�;����c����#���Vd2a+��U�e��z��Ax��@�f���Ăo!ƺ�8ʼ-���H�v��"_#X��̋7~���o�P߲ݣĹ�� kj|�6��/\f�6�sm�/0�Ę��+%
F��S�>�hyy���9�t�٧"x+�Z]��y kS���漰��������������3�*�Z�z��<m�箲��wz�K�d@��C��b���v��'��\�Ж�E	*��v�b�\r�<U#l>�e�zC]_�yd��q�,ގ��Q���4��gs�rH�Ҍ|�\��4�Jv�C:'��U�)�z0F(���dy?�F+�G9�k.�[���G;�er�[҂H�d���dzH�:X�S��уx	�\���L��#1Q<8�^�[0���?���Z�v3I�:⬨MXdV����j?F+2�%*����2_a�����iEn@r�x�o�=�w�Wz���j�O����܇��~�H��D���:�M���h'\��}l<Ȣ���f��}+e;PB�#2�p8�w3��<�)�)2�y���s����z"�Բ�MS�m�/���V�=(�3�����Yy��ë���{�"�⼸C�rD7b[oN7��e
h6����ґv���1�,T����:,��C�?t�?�f��;��:���Ye�D�2��7���N�<QT�k�(���	�Y�H�L��7V����?��R�:�{"|?�b�k	�yI��%nN��u�nX`��{7���l��~X�W��"qPO�y�: 
c��ؼZ���,E�x;��n�C��������$��D��C���D&Z}�@��N�#�"��:�»Gf�Fi9v�3���ТнK; �V�����4G��m]�BQ��?l�`q�<π��o�S�@P#A
G�)�]@aL@��g�2����Z3�46;�+?�c�d�y�Y�/��BF��a���:B�����d��A������[�ܿO��r[^��=�� ��z0�	}ۊ��%Y%=�<W��y	R�r^ɷe&��1h���W�J#�wg6�e���#�n��m��'ͨJ���V�$h'�H�[=]�X����F�y99��y˻y�gX�^��׳��=6����$v�����uÀ�M� �����)x/����sТ;Z��"멘�J͹�(X��͋}6���;�ڝ��F��,��K���4����j����h�n�tx"��:�'Uz{���d��ډym�Z��'�>��J����Ftu!
�]uo�27��3<EJ���fՏPg�%Р�=�������#�f6�sWu�����g:�ں7�>�72�1��۲AC��p���|ٝ�՘�%m��<`�i���*I)�LI�W��_�1P�z�'���=�5�]�N)r�B|�ß��Q/��;nH��(��1�Wي'����ƍK���3.�I��}�sn9pl_�[��L����@^6)��ʫ����M�'tE��*��(P��l��(+�������'[�Е�<��l	��+ k�N�!��<�8�i&�u���I4�����N�g�\���x�Ńg@2d�4�amdԼIW�QqP�>7�X�S	���s��~�x0Y��X��H�掠)މ6�X���b&�vƐ��`�Wb|~e�J|�.�����[ ����/�z°^+�n,������#�UV��<��ڈ��Of����7��#���mi���K3"�R�P)Lb���ZwO���;͈��x��[i�t��}�?E����	�
��&�Y��8c'�ոB�zbz�׆,h~��1���T's�ɑ���p��,Me���P��.��y;�4��)k����%�FI��� $��U�"��4A`ءbG�ȕ�}�i
�/�lo�������y��4D,�vIcD��2$��$gX�$�x��u%d|�8c!���v���.m6J��lɀ0��ſĊ����O����eh���±��܏�ά5���eY����K�nZ�?�e������9R���<��#��vՑxm�/�q4#;#�"�B�;���"�M���G�){��Ux�ׄ':D1ʲK��5��/��PE���|���NlL�zb�I�+궴j\�ni�:5?���<������/sQ
hP�oGn�X�o�<\���J?�.UơY	%}K��e�#h���\G�qe�2���QJrA�IK( N�}ڬ	�Mmք�:�Z���∗�V�U��X��;�=���4U/)H���D�]��ΤRS���?I���oȩ���J/�&��c�Nq}��R�הm�𒴼G����-AjA�~4���3�W)�!���ǭ�&GH�%p1�����Ùq=�j2z��:�o�v"6��;��p�g�=��F��\S���<��.!�ɟ��&�}I}%*��Q�}�7������V�sB%�ܓ�RC�&�����A��ѐ�g_]��˾�$��&f�D�-J�e3��aW��S}�t��>��}4����l��4�����l�^MއD�xP�W\�8�عK�V�{��W�d����R��Z\�#7~���'��;+���L���xc��i"I-�8��Ȭ    <������<��%_#�և���luBBKf��%{���O�%`�^��ः-����3HV,�c�� Ǚ}2'���my�uq���&�����H��̵p�<h�r@��@�[Ay�Ŕ�0�
�\��3.^���!������^$3a��8J�$�xόk�5?����غ��׭If��;@²P�lN2P�n�Exe�y��fN��:B��v�|ul����N@�Ǎ��֬� 	�ёN�5b��p3�c'9���z������yH�$�/]��s�Ykm���?Tz-�����2���3�ܠ��p6 鱦�e"�-�Ӗ2�ߋR�ȼ��ђ� �Y֊$��QB���8�5��Y��6a\H9Q6�3Ρ6�M��V�K��c�V����hS�1�޲~�x/}C{S�L�z�"!�m�l'����E�[��E	Y��VQ`��P����On5?��F̢��V��~����W�W�l�J�۲X�P�h� �%��,�>�e XBʿ�9�;�EK�(YS���[�-�%Y19�������"^�8�ޢ�j�~�{sdǖ�y�HT����Y8	[�u�a��zl�_0��OXz]�Ѵ[��%	H7���L���6�$�f����������%K�/fO���H�|?������!�M=}�Im�����ۇ�|��[$9��}��5N]��f���S4�Ua'�@��	�P���l�,:c�szr��$��TO){4ַr��|XcG��
t/ܿ4����cOG���-���C#�-�K���-�����
<	pa�p���:��>�$Pi}�yk�- 5.r��ڣ��C#/!Mt��l����;0�S�Mzh5�ތd�2���Y��׮���V2mK�(a��L��.`��z}��>DvD#D��#Ӱ�����)�&�����j{�e��y��$B-�LE,g��q(���CG��]��7� +t�gVl&H��J�X}5X�y�g۴���q��9-�W�6��}#j#������h)X
��m�?ՄS~|xF�@׶6ɾ_�O����ieff��Pu?m":X r�h�
��,$CtE����9=�P%99�	L�����u��/ܴ���+��O�Ɯ��x`����t@�݉uهF3�N{�k
i�5�v�^������N\�ٶ;Z���,Plpi-2��L6��~��Mb:4�6�ާuf���-q�?A�>q���R�\��uґ3��l}�Uqk���CD^���T:ǾM�L�Y�b�=Y�y��{na3o��v�p2Ŕ^r�Z�d���lB,@Ev�nS��LkGoS3m���e5������׉�V3��Ç���r��316-2��h�f�S��Z���9��n�&y��jm�����Y�ތ�k�G���YY��9����'�R0�B����������?���4��,��4���vhM�&|c��Y�J����Bfy�
i��e0�7=���f�f"ǖ�+����'��pz5�XRQ��;�)	[ �d��Y�X(O����V(�9�����bشH��D��3_u=���:�p�4��,�P�n����9j)�T]8S�;��=Z����^���1=��Z�8W�Q���ȱ }ے �I�����zSF'd�rc#��.1cZ[ˮmv=ԟ �E�j�gY�K�Zx-��VׂB�f��Ԯ		�u��:�ڜ!g:��������y}�d�-�M��Y��]�f��w���k�tµ5�um�6�]����]GY�n�"B/,"h��X���b�B䟒���R,��V��p`�;���9^}Һ�� �C�^��PK�1j\�ǖ�'p@�7з"�i��A.a�n�5�Ɵ"�gA�q�l���$�\����L�a��̑�D�I�
�֞K�`N��D�W�� ����NZ����sFQ��"֋$��3L̕t���Hj����,ؾ�HT��q����$�sj�rN����qm�2�;�дoMp�Y��C�	f��)B��{�؍��c[pz���v�U3ߴ"/f��@��������T�Ƙf8y|SߌSw��R�mo�������.
�y�킕M;X�']�I[�!�(��Z��# i+���4X��*���`���b�ݛ�s�;VT�<����� �ko�;��{+Ӭz��]�����Mm�!�g!�gn���P�"�q�g��n�A��	�3�>WȳJ�����Z�ZޘtEi��xW��]X�Ŀ��4�H�Z�ǉf��dTyߘ�U��b_�D�q����@���oq��_M�GB�(T	}H��96z�v�m�<y�k!�q��	�0�$.��G���kox`}?Y&᝗kKy]z��R�?�+-��VXS��^f��}�Z����3qb�~�	����Qa;�7��[2��r>� �Q�4�
�D] �,�G�V�?�yM���,di��Mz��@LL��N�xō���6����`��h��By��-�K�}�`�/i���A��c�m|�4v�?~:ژ&ѥ�n�ώ�dŢ=s*ױ0L7�v��K5�k%�kl2�jB;l��vSY
���x��̃����^Z4:�)��N����h��.X��P�b��I���yi��u
��cRB��0R`��:�,}�v..?D(H��7�G}:Z+ ��*�ά|ဝ����=���t���b�p|<���׻K���i��yb3=O�-���+��|J���
N*B~�V��e��F��a�SDg0�VHw[
���Hu���*��D��LS���Y1���#KP|]
���D�M��BC*6'�,�e�nOz��~$Z�7�K=)���<����8��x`��c�.�E�#�a��4����DX��oӷ0������D\��viz��%�.)�t5�^of��rk��(T
]�VR���:aչ����S��e]Ste���4�k����l(V_0��= �`�^�˚9�����}�����!#�V��Ϟ��;?��kIh�l�g�t�)%�+���3�W����r�q`4�U"q�Q<� ������o����q���7��!�g{@���l��7�'e��4�r[;�o5�/��A^O����P��v>�h�N<�����`\N��d4G�"!��ڌ�A2�蝷nK��NAmӜ#�=���ϲ�LTۅ�3�-:) ����#��,�sT|ޅ?X=项��Vj�v9�w/�b��v dq[�z�~�A������5���֍����MD랖h�oS��"�r��5zs�Ҋ�BT$���b�o'@�o��G�v�h�-ˣ!��K6��S��O 6t������aM<�v�:,����P\k>t�5�RF�k�,��fFt�ޔ���u��C���u�#7������mZ��	_:���ﱁ�k9ݦ9c��1 @vh�H�=�	�9�pg������6�	��d��z�rA�~DI�M���M��ȿזٵ~X�}�V�e%�5���i� %�����Y���l<���Ć�Q�4rbM{��B�M��'r��ޚ�3��� Q���4�xd٣�^�k;�8䆦�$C3�Q����t�K��?F�H֠I�,���S�� *���	�w9�5{G���p	4�O���DH:Sx�E�-���=��SUӿ802^��s����#|��v��B�bk`����{�܇�;
��%�ަ��j����}����x����e�Ghק:�ܫ�R`]�_��n��˾k~¹6MYgG���x�HmU+u�� s����q*����~.�ݨ��*F�]�4�W�	�L��R�ݵ��I���m�Y��\�����h2�g�%� �+{BP�Y�Q❢@���u]{�i-�QN��4AF�0��ߏ��K���������2ŋz?AE/��@��;�:J��f�Y�,�%?tY��N}�o*����ٻ ��h��AR�ಠ�w�!�m̻je_�a~*$������x*�K�椂$��,��q:Q��X��yY/�� ]��}O�^t�jN���F�q0j~8�H_&V-M��H�m[���O�5hW��x1}�����(	��	�	YO�-���,�6ŕ��L��)&��    �N�<���.�`�����غ S���yؓ��L�-57}ͱ�%�h��	7^m�#���f�o/� ����>5��Z"z`�?�鲌�:&y����M�R�������:#��tUR�a�v	x9��2�����z6>Y��aj?$�=��A�Alڽg^'�MІ��z�� ԕ�}ŦJ,�����n��o�ɛ
�ZyCZR𹃥���D�0~���k�B�/_N���B}�J�i~ojv��M��N�g)�sOժ<�5�����O����h�a��sF�i�p.�ѩ?	��@���j� ?Y�2f�]�̻v76^U&��a��/�����O@�V��XCҭ�	�)^CJ��8���Ë�*��P��Y~�3��?�
GY��g웗������$]9��b��e3�
�	��i)0ǒ`��Ȓ��sƓ��j�-�/�z.��t���aqU]q%��%yT��t�U���BO^%�!Lۃܝ_�|`�;�p���Z��~һ�B�`U�-Q�z��N*ї��=��{�I�(�P]7dlY���N�g,��E	R'���<p̊�%�����4�(�೘�R�:�,�^������@�n���ܩi+#��?�޷?ҦX��A�U]���,O�soʻ��7��rN�q�$���	H��">�C����������T*����
��-�� �����M�e��M9�����[��:��'��ޅe�)y����c�����+6��=[�ƅ(�����h��̎�W��A�������c�l�Ky7f ��R����A���W*	I=ў���&0�6n�3�G	�� �zEOE��o?���D
��u
����ؼ��&
qZ^Z�c�n�wUm����}"B�\����}���@�+���k/�V�����(=�|�=YUOn��\:�=�[���y.һo# 4�M�<������#���ˎz�j���t�\W���)�ur�bˢ����zne�������5���o�,ʱ��R�{�6-J������r�HG�0��kyi�J=����qM�xH�m-g\�'�Y���ޙ�1/�+�nS��?z��#W�)��n�?][����O�=�o�Ci��^����
�y�L=�N�Znu���{Ӎ%��K���I1	^i_���'���?+���6�Z���CY|�-Ε���q.m,l�DѮ�U�ҭ��[���@yr�\!����Ȯ��B�+x�3�kW��}�Yu��UA��W�ô�Ȫ���~a��Զ!����d�W���C d�q�kk��3C�Y`�K�Y����+����A��P���X�yt2�,�|��h�)��	\����<#�S*'Ew<���4��;~?F_�<�~$<�SR���/������,D ���T�'EѦ�$��з_��N�S�d}��5��)��:�~��G�Ђ�u��2x�a�L�ȀEte�]e��h��o<3�.X�ek��/���X`����c
K�^��Z��DIy*�Uqc����+3]���'6pٽ���rϻ7���$<�ӈ�F�|)���ƚ���'Q��G����uDt��i�`k�c�^*$�4��
xq C�$���	�gs1���R�9�C��)Zڔ�I�];<N�`O��g�����ӻJ2�h����̟7p0��@Y���ؾ�6J�L|�6�<������y+f@[m��	����ّ���T��� ��_�ؕ�*�o��P#�ki$vM�����m�<yE0#MsR'���iH��`�{� ����GI�A�R�c�ȭq������!����ܖ�(:��tm�i&��O%�W�QR��=��̻�7���柈��+�s��-Q(ќX� M�E��o,���g����ؐ*���a��S��M�X>�Ahco��v|��p�gd8YqK# ���|�;�����O-�&���+�衜N@Y׉�#u��/+Jm��BfIיT�C@)>d�,c��h8�Д�K#f�4�G�7FP���}8Nz-�a�g���A<��Q~��/&o�^F_�����I�gPJ<�ש`�*����D�uwFo����Ը�wX��ꅱ�|1���n��x��ު��/u��n��z�Y\i�UXZB�J��������*��(�6]�Ȝ1���Y��ci�-���)�P�Ⱦ�����:�OV8��c�;Ryo�ll���H�碌��uHiM�-.�Lz�y����%x+�H�&�g���U�"pke'��%J�Nݘ��՚OnJFP*x��w�~��Tv/'����7a�H8I�Z6�Tc�_҆�>��nC��DV�m�Pst��x�J����V>hb��ϙ��'��z4��:�nũ{�p�k~���ū[{���æ)N���������i|M�����s�8�Hpg]x.��4�P�x��y�Bq�1:7�,T�'D[.�y2D�ݎRQ���$��x_�c'��_�����)���̀���<C�ƥ���F�H��ij��n 
�:��e�{�(����x�v�i.�H�`�J�:��a$��<>�Y|�Y��p:J@7���9�Ͱ��b6m�XY��y)/��%��j��av��s�g�[�@oT������<�h'�Ҡ�,��'	�WE`>I�'�l���H
[�/&���Vb�8��R`_���g۬Z'� ���(����v$�� Q_��8�u�>����n~^�@U����˲	|�����vm�A�3������#�&S.f}�6�L�p��h���*\L���k���K�aq�TZ�<H&.b%b��&z�Ͻ����ѷ(�Ͱ�����f̃w93.���@��9��u|Nm���=��HE�G R{�ߡ>����#���hO,�\!�!�f�Yv���|���Q����_1exl�\�w�.6�N*��Ʋ����RO�s�pX�a�3p_O@e�޴�v�ju<6��������R?ڦ����Z̐t�	�duI�w��ֶk�o'On��>Y]��B ��3Y�,����*�3 �d	e�W�� �[���!�m��:ػ�d����J��z�^��3l���x�o�c�%r��v�Z����E�H�`�F%3����Cɹ�I<h�F�]5�91Nk�&�vӸ��P�w�s��YQj��(I�0�)؉��!�_�=���]@���&�`p���������o�.<J����N�N�jQ���+7E`e�x:^E��;M=)�E�T�-�M/��e���,^��=�H9J��\�|�#�s�0�Y*�i�{N���-[�blK�ٚ�y���U+�,d�
^��̳C[i;���rU�Y�h�풽NGS���� i񿙿�ز v^��C��p(�-�H��G�Z��b��G������L?ڳ2�%ji�埼��|����[?�pUƭ�VCxQƞ�xE0�=����ܛ�oVe�w�K�����:�+5}{�≲Abh��le�	m����-;�2'Mi03�(���Cލ�ϐ�记�!���&�AM��ߠ�����>�V^2�O .S���H��GP� ��A�Ѡ�%�^y��4AUV}�P�N��1ʓ���A��ޒ	��M.����aF;�h/rBA����z7;Y��Cl��o��%e���`)��ۖ�� ����>R�R8��L�]:��wx8b�>S!z<����ke�4R��'�p"��"�o�V5��q��H_D�/A��[��럜̒v�7N��M8/�*Y�jJ���#�p��Ѽb'��Z��=#��Ɣ��tJ/��8����'�P����"�ie��)�J�p�W<64Htm�|>�V�Ν�6�N�������!M�,�-C��є���] ���K �F�_�_Ͽry8����Vj���wn��d���<�o������d,e�(�M�B|���$/�T����J(Q�G;F!�_�����e�f��߈r������c���!V��?��WL^	va՗cU�k�[=�c�A���m��^����V^W��x���}x紴�U��VU\�)��)k	�4#!Զ���"I�S    {uh&녢m�
\��XzD��y~��(Sz�Ԝ�m4��h�Ŏ9�}���t%�'�~���l^�{�r��'J���J�=B���R�5G����v~0��v��{���=�9a��)T#�N�\�ՙG�?��I+ӱ�:�>�RfV"Q�Q_Z�'��>���oJ��l>�����Ƃ�ơ�3������M�*
��g.i5�5��n��s�,��T��S!Wff�%H�8�{:�>
���v�{�P��+R'Y��g9�c#�*��"�rb+X�f?~�O��t�������Vֲ{e���W�L�ؽB����~�u
�B�'�u����ꇻ`zԚOQm�%�ۮ�A�XO�Z��Z�W�������9�Ft�R񡏸�z	������?;bޜ�4�����,X��6t���M�����C J�x�:�=m�Oج�x�����mxo,��R������9�M� ��Nb��p��6>���
u��DY��$�к�Aqg}�!1w��x
����i��O�c��G���p��ump�r��#���Lւ�޼Di���r��X�La'�_{�ו��~����K�.l`�f۟�痳��(טJ��(�Ryom�S9&2�8�u5�,������Ҝ�sPp���&;4g뭽�M��4t��/O~�t.|i��M�k��J��i�7O���( 0Gvhh�:)ɫ:[+���
�����x�2Ӆݞ�6-t�ݡ�w[��,J���6�߰�,U���Fm��ʸQ	�:?ݣ�2�tO�#9�h��̣�$��ij즰>�I�j%��m=[fm)�5��>lv���D�R#��m�H��Ύ2ɕ������I]j�\	����-0V�A��r&tq�h���%��������ߐ�T����� �0>$(����*
t�Bk-Z���4��J(���9eK�9d�~P��Z�2�D~�x��ٺ㜠'Mx$q�z����V��v�k�b�� �k%�����fִ��L�w�='���b��᝚�� ���R��N�f�QA}W �U���ku�{@�NI/.Y(����M ��^'�f�a���؜��	\��ۏfTe��<c� |V���
]�'�,� ��!�shI�Bx����vS8�M`Z@���V�I
���ݩ#�n3E՗f��噼NM,�J�ʭ���_���,s+�4��`t�h�������Z�L�+yֈ��ue�ʑ)�`뭘���T��6����V�Pe�L�ql�����I��<����%M�$#`� M�L�)�iZg2ʓ@�I�D������<,~����O�H��f�q#,���;q�&�9 �4L�{CYA��Lg!cos�J���[u�o�)޿�bd)��rv�]M�'����u���Q��v.�{����c��*OGk`�E��u�r��H�����|�õ�	Ks=l�/%�ԥ&�Y�h��dom}繎s�={��9��_���zj:
�JՄ��^��O.�CC̍B+��eɑJe�"Z��] }�A�=�6o��v����_q�������)���A�|ekeX���h�������sf7�q�5�����P�k�KC,����.�r�A 	H�V�N�k��Wr �G��f���tt��H[}�W��̦�T����?��kR(q�u��U[	�.��4\kF�K���]�Z��g{	��"����N�O2��1L�AUOl�}���I�Y��5�؝�b?���AG���([�Ц$(��]�v�Pk>�Rf� -3\�*�[NSs������4��8ް�Q[+���@�x!�]^4�,$��+&�5���T`-G� ��+��Q����{@^|�zKn��E�}e9�Jć��b�أ��52,%�w���0Q��Lj��O&�#�>A�-����νu�?�9v6y*)0nF+��9D�6�r�p�橍���;���1d"��Ҩ'��ۍ<��r2�h�Do��,��H 2 �ܓ?�Ӓ��o"�|����M���/����VO����B�I�Z�)��٬�
Ag#�^k��$�஝fZ�������k���&k�^�ɭ剩P}�̦�f��}w�O�>�y_�_#F�s�3:�}��r�9'�&SA����(	�=����u��)�[)�R_���|�d+��|q��h}Nlq�%����͛��ɹ��sfer���M�i_@�O;�K+I�Ak�0d���Z�;�l���[!%r���1�OɆ�Aqo����;\�����`dL��1����+��tk�l�=���N�]�T<c��9?#��c\�Dڂf+퀙��ǚ2a=̫(��K$�n�E��[:�-�A��H���%��k�����F�V+�t?���3���UcV(��]7� 3��j���+�RX��b�'��6�u4g��1$<��V�*�[��R坖d�[���ڕ�����TR�+�.k����?�<r����8pt�����A��5�2%�>ہX~hCOMWS8ݿ<�@�Q4�H��������i=R��R�+�E;uE6���.H/�w�� KY�`#i

,��Fx�|a=N�ٓ9�_N�5{��/V�u�e���!3Gl�ؙї (�4�� ��<���L����Y�\�G��zSl%E�2��;l����,��Q�ԓy�);�ʣ%��s�_�+-��a�t'�;�]N�H��'u�k_�:؅�cI�����ͮ���t�D�_ܕ��/� ʻN�9<�u}��^�1�+?����3Ax����ډ{s��9X@��00Yv�j�J,��%kt����>oe~c��u�X"Փ�w-�,���\���<ּ`=Nچ(�6"�m����^�y���ce�� x��\� �~�s��s� ���?M��hwU=�_j�j+f��II!zC��r~k4~Z$���B3<J�]3��Q2gTǄdW����ݞ�����9	F�I�bC��ȨP��W�F��d@��Μ�������KM
c&tȚz�i7_�z4�@
�ۜ��h������e��v(E��S��^��j��1���A��|���w��#�0��I���x��\�I��~�7�e�O�X��T3K{�3��n�b����-����TN�F�LK\�x�Cq��j .��9wdm�h��_�U6}�^��n]�ҥ�%Ciͦ�[�.��Z��*��aU*uBW�h�0	����a�h��/&T���7�����R��dc�ό�����v(��{��n���op|�#ԏ�
�w��rL��`�:;'v�xI���ϊ�~��E] �j��DO�l1����O�K2P��N�ք	��.NQ�H�'�=��b����5�� ���ۓq��������@��v+��?u�]�^���zqr��?�wM�Q��y/X���G:����tݍ6�oچ2�V:{I�X"��"�\��gJem|��h�g��Ax/�jZ���'BA}�h�C3y�fF�Dp�b0���E��gyS����]o�Ϸ���
,;�����H�rG������цI�ǧ�iU�[.�2փ��W��p
Os��A��y����E���B�R�W�G4V׽tY�3��˹�4���镌����E7ͼ�È��b�d�gvflA�E|ۯ��l���޵t2Jb���(噆��[�Le��S�V�,������F��qRb�=^���(�O)L�x�x�Ky���D��G�e-��c���z�S�=�@`�B'(e����-�M3߰��5xe�Ҥ����#�~LE��2��=sFӌ6k�[S�ZQ �۰��3���5������@���Z�I�Z��A*SZo��(������jaֻ0B}�w���VGC�O4X���D��//M�R�k�>X1�'���Y�.xz
�3��|^<Ŵ��${����c��\r,|޲7v��l�s_��PIX�b7�w�5J��l�57�Z�ي�����]��z����^W�alo߈�UQ�m�S�b+�9e�{l���^qF{����*a"�N�9J/����N��0�;n(#���$�=	tõ�˚�㩘�ć��.�� Z� ��L.�ݠ5z03�͕dӱ�    �3_~y|�j��4_��_A<����	��g��q�s}af�b�T������((�����#�
��	~�������l��D>���])W���A9?���Js�㋓�(B��o�L*zW��W\�#5r��W&��%�(��o.��/�/�#|p9��RY{m�w���`�uK��A�ҭ�h�Ĭ`��=ia+	k�`C�b��5I��n�'78�cZV�O)&8gag���iaEY[�)��x�/ i �b��J;X_��>1�ϖݖ���t���|� �s���{@�e�^!��aܫ��i�.e�-.��p�I �s��\���D"�Vl��uU��h5��J�_S�
ˇ�� ������ڻGf<�vi)^���[6����s�>@G����h�E1%���ڌR���EҜ�!C��#
W��]>�G���c�?Qr��fI}���R ��@/�V[,�-�R��$3޴�7�SpWم��
��Q�V��,���k-T�e�4�V��A��b�]�8I��B	3z�H�ɟ Ĩ/<���N��*�Z��+$K*��>bi�V^�qI"c�������(�Ow�0����_��c
���#�Nb^�^Z���Aq���I���w�.�$�S����_�k�f5rF)_;���'��bE�lQ�;�s`u�!��c��-�`Q�Tz����m��������ր2�ƿ��X��%Xo5zn	��K�'p7�&\`3�$��뻓+)O��nr�)h���p�N�v��߉����7F��w!U������@7�3��q�_���]2��A�����fI���JD�b��z�����&��6&1�X�j)b(sIs�[_UU�Ls�`����aS-tL��c��{D�~#r�GIa"�����#�i�5�p�V�:9��h7H�:���x�����iTm�<J��Y@/�MllP��԰����4�!{9c �TW�_��MKa@���3��(B|mD4��'�4؎b�����y�zv����#�Q�5�1x;t��̌��TH'�,2�<��ڶ�`����g�9"KC�  D+�N
5PFɻN�ض(��T���L�" 8U�<�x��x�����~�	�	&��Y��m|#�SX��ɳ�q��������V�*%�Z�<*�3n.�m�����2�g�O Xq}����{�?�� �9y�m��N;��`����i��$mRbgя���0j�Ĉڴ�?�Q}���e7bN�Y��5�:}�\�$�������m����fJ�s�"�>U&Mo�jFOɉ�(>�Й憐~�SA�Kg[��ti��^"�V?��R�ێ�g��7����ұH-n��Q�]1Z>��y%�o\� ���s+�UY��<"h�1�)���9�3�MT# ����1K�9B��6�܍���O��T��}�?�����{Hh
�(�5��st�ge��-/�ˁЫ�W ^����84-����\�B��^����Hbڅ��Ψg7����[*���ո͈����� �����g�6��Ne5�}=?Ub��}��M�̌K�؉rCo17�d�eO�be\α�	�_�Ku:.���ԐY*xj� �D���DY�HJ<E9m�:^���n�����2/�G.΋�������.���������Z���E���J\/,���{"B��������@
��]m�M��wC��A�pf���!�j�z��?�)�!ܥc���h]R������H@B��yЮ:j�!G�x���q�c��n_ӌRrF*�P]�eJM,��@�ұ؈.;��QX�{��Bʫ2APH����L��W�bS�8�jW-�`Q��2�E�_��g�DRI���ݶ/�by�Wyy�.��QBÚ����"z�`����Ĝ�$4O�b+ω���[Z���m"�]�/֐���m�c��uO����&|��OP&
t�I��J>1,�U4�w��e�c���UU����$qݷ���S�!�L�71��'"ύ�!hp~���X�2	\�X2�#7�S�nGV��џ�7�����T�4���)Z-'���*�,	����35�f ȉ'��=���0b)r�6�H�����Q�{�i������K1��S�p���%V~���ᰫ#�t�얝�����6�x�b���}�~J�z��첍{���s (}��G���!2sBN�����d2�Ҟ~�XC?�zS�xb��W�X��Y�ފ�vRT}E��h���J;4����T�ȱF�s�%�ː��Ϙ��cC�z���>6n�����W!j��Y>L�Qǜ�>�`(V^ޥ�U,����[ډ����.rXw�m8i3c���(Hy���L������2�)��|�BЌ�]��QF%��e	�g)�Q` ���Iɫ���Jmȹ�Eq�\�tӮa=s͒�����䑆����T�m{��5�ٮ�q~.��@�Lƙ�SS�����L�c�0N���p0P���;l?��}crǦ������W�T	�ϐ~�;���@���e�>oZ�~/�^���4[�I��_|���5�x����H���4^ڧ�����Ad;ĕDB�:g3U8��t�]��׬bS���������S-�.�]�(�� T=o�u�h��|A|����,�E(�4I{	�a�	o���BZQ���sW_G�&r%�-c΢����Bhu�1��na��X���X�Gȣ��E�zE�[j�8�?H��t�$t�PU��+(B)���j�#,Q�OƠ@져O*ulw���q�C	h�б��0�^���[1�d8��=����(�^����Dh$���]��%�r6Y@N���vVJ���5��o�K9`5*���e>�l5��dwR���յ��O��Ӗ�(A�U[�k_vt ��T�3I���6&h�d#�C��%@���;g�?E�W=!��4|�h�P��KyJ~�ϲ�@����֧�H���kv7�L�2�ǅ}�=�Ɲ���&J'Ⱦ%�eJp��>�5"�}k�~���z��2,�@�ߴ��,��ԕ�,:!�k�p �#��,��`.����|g�rv�? 5�(������7��9��ZȠ��n"�f��6�-��*i�;hS��T ����E��\�l� �c��eIt����<i�0���޽D��oK�>㉞�EԱzۤ�D�웵G_H�M��7-یЊ�z�#�C~6��8�#9Ԣ;L�WK��H�D�����F��]��6�C�n��xv�fw2�ZBE(�Λ	� �r9��%{~� �f�,\KC%�E� ��Q�	���� �ѼU��M?��GφNN�̚LL����|ڊ�8��ԡ��M�??���_���+C�:�$,�vo0��������W#����7��ܵG���ܹ�12�������ҁ��6�w�e�PҴ����E�f�n�hu6ӿH��"��(��������B�=���J�P�k_k���n�r���K��O�����J���s�W�'66����X�BW�����ej-�z��37�I��9E;��M��x(��j��[l&7�A��Qy�c
��j:m�+��Qlk�f/���]��G-�~�?pϙ����>I%�֒jy霖Tg�f�0��6L���·�����?7�8�3�穅
��ؔ��}�pД�@(�FX��1�L�<�fe����maD���F���z����J}QBv��X&�8��ww��׭)���5����O[�&�3�"�lh���|���Ya �N�;����}J]w��x�o(}�>h��_��ٺ��a��)K��P����Ѻ�^�0ٴ�_�9D�b�5dj�iT���(�����jaU���,v_�o���R�`uȈp���ƒS�6P\�$9ķ�1<����Q��DQj���L�ʻ	`D̰Oj��\'q`ś��m=E�3��@��?vSl�ӖH�=ḥ+��;L(��a�@g�xSn(`R�7�_���!�`V��˲�՗@�;�{<��d���T	rxS�����(�Y�ɮ��f@>K�b3�}8��X�f��}�sK�/�������=��	}Yl�f�l#^-����YF��L��gK&�l�����]@�`n5]:��� J��ڭ�5
��N�e�    Y�Me�G���LX_R�V�<�A�� q�zw��$� �����"{r��1*�8������hC���M�g'��_���ܺ�>m|�ۼ�� #�ZC���8oӘRvȣ�,SL9�,ѻ#[ b����g����T��s@4�V�=�S�9E��M����YQW�@|}�j`C������y�s�4d��C1� �f�S��?ն�7�A�q���9�B
l��"U'��x�'��W�g��<1�@���;z�mVֿ��ܜ/�J,�4�?�׺9���NEU��̌1	N"�)b�X?#�p9�_�A��y�ͺ]}`��M����wR�'d��k�S(��bW��D�HK�xqv������+��W����T��j�sqo�����:s���'���!;�+��D�����u�C҈��m���©�#�YN�A�yc���ܵ�#B����sm3�^Ǡ�^D7/����
�XǿP`�h|-1�t���9�����@f<K������2�JR�n���W�G�ۥ�J�6b�/�Cl9Q�����\o�0����g�|0#'k�ײ!���_�;TFE:�V��O	��H��#�������ö�([����-��FY��"�8��b���US�m�&�k�����v㸲-���=��P@f��Ѳ�P],H4=fUq�	�JAVB�7�-�d	u��E����*J��[l�l���>�Ě�5�Hf�ѻ�9fdfD���e�1G�d��j�����]�cjX�~��4R!^i���w��3}�?{�#޾&8�S	ec�����m�d:QB�1�7B'+��΢�ݧI�C�

���m�`������
Ab�)�=Vn�`��ɶ�>}BDC�=�Uu��Mw���������?!<qLvGL�s�9U%+4�h���!ʇ,>�!��G���O�w 6��&���N�N+�'v����� %��o�GUt�~��3��[��ȇ&�i�^�	��o-ph�� ��_r_�?U��2�K�ж�y�tH��÷J&8R:�LF��{���WN�\���FG;��s"^��@����YN���T����{�R�8w���Z헼�!qr_�?�~�S/֣�3�ٝ�����0t�a*2�Ҙ�7��P ET��6�O�;<v�v̌��ޅZ
�����͈O݅F�����/_�2r�������Q��L
�2�@<��Q��t��DU�RF���?F�6T���?#�;I�QT��(��dہ���׮$'2��z��6�v�0��_[�H�h49�]���j��hb�6Y4`�s~D,\�d�Q�H�pތ9�$Y��*#�JI)E������2�`	H5,~:��w����G�&��_<���L�jWP<�ud1������6�e-��~e! 3!tIv"2�,M��\3w�o�ҽϼU|��n0�8m&G��J���s��A���D��+��=���j�[JFF��kt�p����4��4n�aG�;
	�l�^x��ơH�:�tu��&
���H��T��R�'��d(�z���- y6;���PD��0%�c�m���K�e���$���IT�'���ӻ v��5x�w薇?�}��>�S)Bs�>T�ѾN�E���!����Z�k��������䜔�.ܞ�si����;GP>�?Ad���~bE�#w�߈��)�0��?4 _^x��S�w�p��-Y�[(�)�G��iO�@1 ���'�.�F�=�#����z�3�T���Q�j��� ����J~�ڀ<�o
 ���}�������vQ��'�׆���\qҗ�߮j�p9=-���R����٣ٍ��~ �o<#x6�=�#pB$|�S����Cs�����'�,~��Ҥb!6�z�+�q	%|�3m]�g����Ͼʒ}�}��[G=`��� �vP>�����;T�d������࣪���O�#m�>S��x��Ԧ9
{�A��nF6�@ߪ�4�Ԯ/B�l��oE���E���*��M�"�(��<*���JI^����i����XS��4�QxD��hB�8c�0uÈ�O��<P����=,7�'���m��2%�`��uP���)�	���e�Cc�Z��1��N��[ZK��ҝkUhW��B�}�EmR����v��S�t��Wą���`Ԍ%O>�ir)l R_C
(zΆ0	ksFQ����:�.<���(�	Y�0��5��)��8�ú����Z�"����(�����r.e�`����%'3�;�XwA4�NC=�AB�_QH^����>�M�e�cK���X��]Sh&7kCBu
H\�x��hg��E�l�,�j��L;�"vO�ƾ�j*�	����@�����b
=f��Y4��Z�����t\�n!��(�h��r����j#��<�Vh9�lDKM��凐R��<�Z ͅI�q�� ��oӌv��sMZp���TtG-l�d"�q��8�������śUb�����($9���&[:>zS㽧����xAh�F�P�gi�#�h%�鵘�Hrk`71��L��@/'ZZ�^���8��M�'r�z��wu�AN�w�i`q�C*��_?�[�hn:��1�KTk�@|�|a�4>bxtA��6�^�GV���V�o'Z~���O��Uyfb^�~d�Ф��gѽC{+M#(�6;�h�+��`R��c��3E����|�!aK���v�vlO<+�H�֦:��~��*&���E�AK;�Ft��Y"��?�?u�nI�'2�(�?����~���ܖ�8����Q���&��PO�Cﯱ#SR�}=C*�o�g��ڬL�-����bZ�9�2��֊,����F��� :ć2!v�TX����M����l��zU��o�FD�3^��X�^{7�x�=e�}� <D���D��<���Ӽ�5ybE�gBZ�QSO<]��LEÉh�yu�\A�p�4B��W�e���qUG����ű���HR�f=�G��ExKr�&���S�ݫ\A>�@�X]DN�y��r$���;�B3Kh��@�;6��18U̹��dl�5����}��Ӆ�����`��(��M��>�{cZz�x0�I��Hˊu^p��������N�} o�w.�f�W�t�GЉfġ�|���z��� ������M59?'y �|<�5�s�!I��]�[A{Vл"1���5�y�E�`����Z�I�ƣ�;$��7/�jL@J<�U)�J�栫�粸��� J�ڱpֻ.����~���e�KlS&H�{��F�N�M+�a�h����w;ޒ �2���8)�D;��(k�'�)ȥ��0pi�����"�a�)w�%1��C:�S�Fu�C%��#-
�������H�������{��:�9~��� ��i���-�U�'9-	g���L��mq�#�
 ��N�_w��� *��H8+p��H�ʅNі�'"��?�C���.7T��}���z(�*Q�w#��!N<֠Գ�s�yy�����IQ%JL \���0)?���+"�"�-K��JncH�"Y��1���h�Y��?�Q
�H�p�[�9rܜ�2�E_NT03!�K����HpM�FAxsPI�m9Q��PӘ�J?���:��t�CɡB� P�r�5���"��Az��v�aY��O'�%ѹ�� �D�MM�N�����.�u��# �m.��U��נd�F�hc~����Z/����!����D�s��=�N�����B��g�Dk�ǚ�E%J��&O�g��v 4�m�[�>��[�Ya=�y���;��FbiDύn����.�ˎ�6���N��.�՜�p�����Bl���o��J9��s��$��{�"�|�g��'�>!�孷*�e�o&��Z����W�"'�y�T ����(
�P?32:'���/B3��ғ��~��i*���)��{>��e��1;l~^%�!m�V:{&�Ey�V䰕hW�o�lG�Nw˞��|���F�G�OuW
̜�6�5��G�| �S��!8E�"d��%�6a˘h�0��q�����q��-���tky߻,&:���I��    �������Q���t��%ށn�C|x�Q��IϦ
6_I>���O�zt�
�e��o��>�j�%fv0�/e���I��q˴�+	KJ�u:����s[�`�A�L�M��9�M�?���JT�]n^��>�3��:�� tH��j�	��Ԯ�b�Pcvp
Av��7��)c�a�K) 9���T�g�W���(Cv��CE9ք����H<�7φt6����I��V=u��7���⩟r崞��:h,���/��"ULo��vc��׽�g�-*\R�����Z;���zXP�5)֘�Mx!^z�Z�m1��l�c��DC��L��W�+�@�bMDՄ䳯���h�hU��l$!o��$��YNL5��� ²P�L⍭�ƽ���u�ڡ`�)ٙ���_+U?ھ���ݪ��`��2\1���Ni�t�Tw�D��˴O�f���()��4����s�2pԗXT-�o�����y��u�����6=���Y<���}\��k��o~��n�3�!ly�x��U�z���[d{�~�@k��>��oLU��ߝ��o�WR}\$2��R����7Sݢ�,Ӛ��/#�>gK�β|����_����~I���h���,i�>�(ҵ�M�G��4� 	�]*�,}��v��rp�z��I%�f4��z�$Ez2Zߓ�1�?�_�oSʼ�\���>/#��L#�$nS[����-r������ioѬ
, +����)�+;�V<��i��ؖ&�c����ca�!��B�{F����/�sơ��yk��U�P�/V�C8xI���)���!IJ"8YQG�j��wm!�Ko5�9�Y��-�TuL��L��'k%�!��|�� d9K��e�e��jB��/Ww�P��@Ԩ:�}��#�$&M\���S^�A)^�6�A�M,�u���4�����\�ߗ��t��'�[ k��)%�w@�?�� b'㑩-�C�(�菓U�u�f�}�6X�	J,�WlsP}�9��6����Φ���U753�8��=gU���>�j�ˇ9X+C�`���GT;��������I�Ჺ��4�C�ф��N$�ka�c2ٶ��Ğk&��2��k��������%Y�τ�޻�te!��X���UZ��jw�gC�k?i%�ԓ�֖X.�u��Q4A�q��B�lR�{����c}R���]]����ˇ�Z�sJ6q�<UG5!a����ː��| a���L �����y$i��>�@�@J^-F��]C��Ο�A3+$�bh�F 'B�;7�>p}o'©"pg6E��s��Y�z����4�!q��w��[�9��U��C�T���M��_��}���i"S3)�t�}�'Yӱ�^�����W�z-��64�4�R��FA��M^�\cfY��lhSj����M��Ǵ�R���hM$��rD��<��99R�DO��(���]I�|T�2�:V}�.�3!�';�Bg��,,����xa�=r��w珦�h��.CO��U��նD��E4��w�d�ҾN[�M� y[��b��&u("�3����N���g�eהI�5�$n"��z4 ^�
6��OL&�X/ ���v���,��O~�	�vP��P�9�~Y��u�8nD�=�֜�P���+��i��]hQy�/��6��0�ϷG���2\g�V�m����ղ����'��pm���ݫ���y^�.^ga�q��%*�Ae�u'QfС��w���\E"X�W�_)��"	T�΄��m��\���D��"��t��l8��۶��X8�����X���c��[ ����@Θ�P1w�+^������uU��t����ؒ߶X�< �,������E%b=4+�N|G���o;lِe-����p��"��A�z��V�į�O�Q� G �vLn�eM����a�'a�ͽ����� ���)N즽%{ ��C]j�e��'�a�]~r�,�>�)F�x����!�:
���#�4�Fc���x�,�A���ZW���Ύb�Vb��SP�e�U�����X��H_��U��CN�ȡ >#y�-�����b2'�9�^jQ��.���9��D�"�܉�� �.j�N����ԩJ<���XR�tФ^����f��աu�!d����`�w��H���א��<T8��`9��1G��;�v�y����q �W~Zx�y W�t�
W[.J�=��|�8*�x�{��v6+������>�h�V������e����j��3���o5d�:~3�6�X�IZ���7��Bvl����/�r0�=~I��0vt{���/Ƌ�$ $S�ca��;t!r~P$�Y�I �F���^��#V5e;p�:�>�ƎU�a��+�1;�u[����&PQņi�Z��ꀜ�@x�l|� �L�MIsCxa�N��5�W9wCpM�S_CA���Wy�+b��$�c2�(���*����۞8qK/�S�4|J���@밦���(�D�$[h{g�e�;�ϕkr��Ř:��>)�n�2p�A���{$�"������xt�|� ��Zҡ���*E�}�s���>k�����Z]���/���݌n������^���Cu��r4�{��ﴭ�gĳ�B\�nZ�V��y��vY��V�>ẽ(�(2�ʌ�
�tx���70< �*Q��<'�)o�`������BK��
,U9�X�U��\��;ݡq�6��^�q6<��Vڰ��Q�����^��� �y����>�μi���͡^;� ���5j��r>Ý���%$�M��'J�|��������J�j�4�ՈIC���O����l/�Q�p%��n{er�� ���,���
f���L�Sŏ��:�nMX���0{�rofԩE` ny��К3�&��R�T�8�գhv��������豙~�}�G�Q�d7�z�ɮ�(��{�zV���7���&�OC�q��]�9*���`�N�ӹAݶ?!|c�;_��Ol�p���
E�KY����mƑnri��)>�)��d���s�Uu�%��N�yT���͔�+Aϲ�U�,K� ݣT�I� -���6���ѹ�ݓ����V��:p�f(�6��|K'|���CjӜL4m�˘��g.���ROq���>-�L�C�O�\�Tg@�W���CPpo����2o���j0�E�"ض�Q˽�P�v��7zW�*(��&�7;��		��xű�r����z]�%p�hP�w�K��
�t�}=���W6?��~����$'�f�����+A!q(t�T�KKBg�U�$�/�p�_t�ݜ�W�+�Lvc��H��N�c[��R4+y	�D����6����L*[5�B�nU'v���&a���<���h���l��s��sk��J��{%���kG7���o�+�y�$��v����8�g�\��/{p��/��%���At�{o&��|�5ʊ-h���d��X�ei����  �F$����@a�I��ڜԹ),$��3}O^����%́7�i7�C���w$k�|�c�w��O�Q!Ű~J�x��i��`���8��d�p3�q(� Q	��$'6���v�Eq~��%;jS�)��C�RK�Θ�{g�@��^[��hO�~c���-���ar�k8}��`��:e0I�X�	��lt/��\9z��,")�"�@�J�G S�������������^��q_�CB��~�ݡ7���xq�l;����(�!`#�D"���JI�c�Ӱ�=o� ��;��AU
��b�������&��q��1$o�#hT��
����굲���g&��O.nI!�"�O]TA@,��$��`�U���ܵ�sOW�ђOi�U�O1WaV��*~���`���l]ڰ��6�7����VZ�hV��c�XbL]��Q��O�Hj�7_��ε/&\�4"�T~>^��/Y_�4Um�퉸�CV�[aZ=0�FyMIź��]���8�~�����ã�)���\� e������_�~G�s��R��8�h�#����
]"˟�
Xh��:�,z��6�0�^��B���G\����5�0"�I�8XŬQG7`&�j�    �+k"�]^`�g��7�ؑ�+��W�`��5�栬Z���9{!�8���}�J�	J,�ހ�>��G�|�V<��ȣ(t��RH��=I-�0��8���������;SI������I]W��4u�H}^��c��RU�$��BIW�
�,�X$�
���-�F0
��y�m��"��?Rn;���-MZ	Ƕ���o�2�V&xc5"�)xE�b���M�T�>s��je��<��;�aP&���S��ҁ�4�ka�ܙK5���=�g&hb�ߕ�<�À?��ɸ��d�����J�`�tϛ�w�>-�kAh�n�M�?�9����F�bU���.��hQ����y�.Rټ�����R׆�j�W�jҮ�kV��8��T0;dAȆX�{:@�,�5��� LZ]+�cW��o؄,�V��Gq����;w ��Ȑ�/4�ab���Q�k���y�{UN��̫�~�����)LO:g�%�h9�d����َ�Q����W������g�i���A�zD�Ç�ī7�+�5�g���4�Upeˉ���Xf�57<�S��{�V�F��b)�j#��K34�Z���-hR䟃Ā��?�[�v�zd9�<����C��)9�Zf�Ȟ	,=@����3�BN����oP�BC����v�|�$Z��|��T6�$�d$Б5i�LL��a>�=��f��u�w�]ʕ��^ I1���3���J�!��k>�����j�i�e	���G_�Q�Q?����O{��}˶;
����#=/ �YC�z���z�~'fU����0&3}�r.�ԞY$	V��IFL����.��5!q0ѳ���, ��n�ً��sw@��5Lx�inI,-s K����\��¹�k��)�&9�P����6ux@�+G�����d��!K��r;{��{���D�|��F�@�W�E��m|�-����h�%b�k �ew&�ȑPvECES����迃��c����D��]�c�p���b��'�;��;�3�M�M�أ��xV�E���6?�A �H\�=^��$N5��f_3�x�]�o�k��==�ш2t��p�2<�05�Dxmԟ�+ R40I�$���r�h)���<xc{R�W���wH&W�ן$�(@U���Bh�Gp̀�l-jjw��ĬT� �%�sc��I���TM'v\z�՜��䭠+)��O�K��X&��e��D��K�Y��a,���0�Pv���U1dW��Acg<�)��6���-����a� 4�V��7q_��⧀��<��vZX�=ym����2l�81��:���@_��*���,}���so�!�� �Ɖr;�,k�x���5�AC�O퐍CP���oZ>���[p����Fh��%�_�.21�Y���ڝyZL�L��-�K�	�K: ��'�ՀYyn/~#֥�I6���Ê��d؏�I3����rOϴp��㒛+ƭ�N�nc"���ށ)ho�RǞ�̇�i�ơ7eTifB6m�jB��fLt�K�.A4�_Z$��cX������Q�k���L*!���'�A뵺��",mR`���5czd;�L����T!K1��;�;��
�cn/�5}�e��|_��N��e���]��GxD���Ks��낹����$w�"�k����j�(#�j�\��tд���@��C����)s�Gh�P�����B?���?�\�(�bN24�KO\�'c�_��F?�
���a�����Ε�[Mm)ǥG�}�xD#4_�{�`��U1��(��x��]���v�jP����ʩJ$�0г۟�N��Z�� [�_��pJ[��í̝�+�x��t%�2����)�����ݗ���v�G�jp����4�bbPZ�U��4_�@p��(��� ,C`�q�L��Bk����0�v�׀�	/��T8��t?�3��I+�L�W x>m�$����ђ�	L��H�i��rU]����p�8z^i���G?�[k��!��n�k9��5'��2��ZKn�F��&�ї�,�4AT�]�����ѿ�7��\),���!� Gv��=��ه���V����hZU�9�n� ��b+��a l����? ��jeą�Ø�SW�NH�h@q�����1�ؾD�:����?�a�5���bL��R�,XD�:=$���e���w�%��",g؝EL?J��_�/,l�@�ǟ^�{Q���k}�������4o��L�ml�|�8����	�Y������&%�)�*�z�_�`I��)�NVtk!6[˹G�\gxM��7g��T\�#�z�b��01����J��2��wS���P���0��SE�d�&�ocʒ)���J�>$t��K>��e�t�Q/,<���,�y~�㕜�kv侉��̴~��槹��W3}�ClT�|X����/�i�ui��E�ʜ.mX�rThWɔ����EnM�Q��ԝ4�/J�/�ؑ�Y/᫐�1��Z����'0����I!ē���C�?����U�B+�?� q��伃2�kJ�"�8g:��㻱5�DW[��/����Z�`�VP��i�hj�o4�^���k���(v�v�!�]�lڱ43=G\ +�,H�mYc�Ɩ�:�n�ڶ`�zC��h��s���v��(�u�T�7806{��/�eW*����O#�7]�g�k��Uj4�Z��[�E��z_�����������U�]��a�|<���/�0߹?}��}=��l�/i �Q�2�r6AԶ>�����~��N<x4W.�˩�`�hx�b���*ݝ�	]�.-dz�r��J�8@�����` }u��gQ�xsoVr�fu���2I��(�&=��)O�HЏh��n0h����z��=i��Μ�,����3����r�#��*����j�Q~���{�	���G��ψ&������_�$2��1g�J�����q�;�MBHv�p����QAu��T��SP�E�ʑ�a8p��.��'�H�����!4��:Iњ��e,�Ul���ӈ������6��:�?�C��:C!�n-����箺�_��I�VNO�A%��~9M6�ǚ(@����<P��IK��hyh������?�:�����E���[�H+V��m��D����;������'�ó��Ş����VY�TO�w�W��m��]-�,%��
�����4f�Ǥt�q�uB�+�S��=md}�%��hx�ֲf�o��)�@7�[=%�}h>Y+�C�lEh�ؐ�v�ד���[J�i�u���<���a�
��p"ZkD4��b]���<@{���xC�)~۳y#:�HA����˖�3�Т�[e�'�����%��/%Y�ȹ�u���,5�p��Lf�qkS5���Ω�i��L��^@�h�#����Mڂ����s�-˛'g$!�M�@�:nF��S��B'Q��`�CƉ��gb�$�SH͢}�|�	��qh\�>���I���=�C��L,'1���PNn�����Y��	��U>
čK�2_〝e�qi�v�+܆o����b��r(���W'B���&�aU�V�V}b�?���v؇�=��G.�k�w���2-�`�bdN����u���Z1a��Ϙ6A���9��m��o���k����騍��ߊ��6LS-/�uEt)q�=�� ���P-��t�O{�=�{�7mt���v������w�x�x:<�Ds�GPA�f,��Ww���{���f���E��@�,2R��;���O��$�VD�&I�D��#Tk���:���̛��-mKic��٧{_kͤoR�nؐ%
\ ������-�\�u����,n���'��x b�g�(D�Y�R��p��p0VA0��%���~�Q��_{�:�5�iP �����K��������M!~�i�h˥*��������mZ��y��6b~�[�Lc�m�?��?�1ͷ��sq��Pq�/�k�c2�<�f��o����_�p��&��!0#i?�O1[��RʃJ�]�.�V��'��Y�$5��=��4�M<`��r��ʼA�°��9Y؁���?���i2��Q�1�    xK"f�����`]LDOD�ǂ�#����*͛L&�I�Bnm~ۺC+b�g���*�Ϧ��J�l��l̀�Wv2 Z���u�����dFh�J��N��Ǖ`ă��17���B��d ��7N;o)��j�Kekd���M�<Q��PR$�����/�+_���C\����Zbj�Z����&ｎ��:�ǘ��Mǐ1��66R�����+����ϗa�\鶸��i���㇦��]Dh2n��j��h���� ��RQ�&?LX���@te������8~������6��edy/|�ǪS1{7ɛ��#��M��P ha���$��_g�O�ڳ��?�^� 4���,drI�Z�aTL�)*zM��wJ��F�3b+�3"����f��z��������İ��#�hY���%�4�)� >ȼ���I�:�X6!���K�E��/u��d�r�Dwf�p.3Z�w�~CK��sr0��J�#(ý�U�P&���a"��໯����#i���3%���h��B�u���~ʳh&ь�������P�+�������CE�=���Q!��<�	���X_��K^x��'�D�^�X��s��4�y�:�*t��>��D{�u�_�I�F_������S]�DauR��6iR�Gy��R�Հ��*E���#e����/j	���v�&�r�k�8��r�ޭ4L7k{\6�[�J;�s=������`p�	�ռm"^E9������Ť�{V�E��\���@A������S�2�|�<���=G/*�]�zA�n��B������S�vAz��i�֭(�'��~�#�}&c"���^Y����&tȫT��ޮvj���ur�h�����"�B&��J��%��n��@��9���	�0���a�1�RX�A���~�����aaT�ݏ�����k�k���2�Z�,����x/��FU=?�M����=`���2�q�h-�tKL�Ⱥ5�Z[���T��_ubq6(�r�^������k�� ���ڻ���5z�~_��M"B��`ď��]:Þ����8��������{<T��䣳��{��c��a+N�W���|��W̞ �X1m�!P��9/LU*��M@5�2�@#�E-��6�f����cq�����L�/$Ν� ETS»��[��]��"������YK=,5�fM"�CɌ�؆�*���/K9HE�ɂh��l�!J�8���4�f��Yc�(W�,�ew���7J�@h��䈘��,D�7?@���w9�<=n�u8RF?w��l�\=y;^��߽E؂IkT��@	N~�5\���NA��,�!R�$m����;S���/�����Q��wq�(�(=��!e��������D^�+�h����oINY��X�u�	�s�h�R����w��������Y�1�W�ބ�E'��)�g�8l�����v�D��C�U���V�������oN������	4\�Z��c�)9sjo͑T+ԫ#�Ԕ����U#8:[GT�YЄ�wf �v${�n���l��:�1Ef%��Z_NwY8ÝA���tV�<�fD���'�Sjp�kE:<��\�᥽�:W,�s������ zV4��Y��x@�Y.��<�	�m�u��<o��?�|'�	�s?���äz�$&��J,�F�Z+�U54����� �,<ڲ����w�,�E��{:�����XR��$IF�;��P��S�W";�j���6����鈂��XGV��7
s:'SzḅԆ�-�����S�D����ly��GS/�Yu2 ��
��HJ��4�jN.�DP�,�E} ���{��v@u]g��I�A�w�:�)�dR�|;��
�B�`�t��l�- [迼����U��B��_ҹ��2��kӤ�ĕdU4�[�jz��WB�,�6�/L}���*_[�����l
��������Ǫ��E#����H-u�	����S�xy� �1��p:�@��x�:C��QTZ�$6;�ُ���v ;:�-�]\���!������>̄1ܫ�������5�&kU��(D��f�~'���1uRO�J~��J��x�U���u��7|�չ����E�Ţ�|��ݚ���%���{��r�XgQ��C?�����BK��r�z�]�����Ix�<�>GΏm�s����C:h��3-��B2�Z��L�`ƹx�@`"��y6vԹ!�١��1�1g�;)�=O�K>��0<t0Pڍ�Qz�q|d��f��$��o\T�}�>��:��n`x�m���=�7��H��^���NM���f:��nMτ��LeӍ��5�M��	���|�[��>MoCw�8�-�m�}��`��>#|6��=���Up��|u�-hkrf:���/�"��堇��Z/���6LD�t{x��s��X�����偆#� ���)-��Ɩ@'$$}�s�i<b�$ͼ�S�R�{�Y�dE��2���X9�u
Ȝ3V]�n�$�{h�v`C}��IX��{ck���?{W��G���x�R�'��+�׫x!�Ќ����^j,��vtS&[�C�y	Qr�9��a���⑇MV�:}�Ee#=l~�׹
�� �*�E�.�Ў��d0�d�ò���b��n��P�(_�SO-E����
�6|�\]$�e���q]|Nx!p��,�-��S�Y��D������YL,Ic�ߦiz~�b���h�����+��:(i\�Ȣ��jNBZ�z|��7!�e�>�]���u��,t������Zo�'=�Xp��,z?BN�[�A��K�w��&�B������J�6��Q9&�����?ɮŌoc;��F�M������L~���P��ktiYl���*UA��
��������>��¨���7/FW�T����n)\������}�U�V�p���>�W,�2��'g)@j�ݳF��t�|0�e/��4��g���h�*C������*�2�_[��m�Si��Q�	�>O}�=^$����������_���t�W��76a駑����x3 -�ݱ� ���-s�mJb�v�0�����ޝ�����%�K�a�����H�o2X��WwF����q�z��j�^e�:�d�����;o*�2�������?{�d)�~Z�Թ�mL�e�,o4[�8l:a� �Lҕqd���C�)���L�G*`�?�J���K��k����Vs�^K��ݞ��x�Gʽ#
�3nYq���942���B_��&��S�_��ZO`x ��W�O�W��'f#l�j�uS���;E����-�)rT�w&��_���FUV{��c���j���u��r��>�,M�ڝ;7����EF�~찭3�$��b�k^x*���L�>|��e�̭i&_��ݦ���ˁ�j�;���W�3)�	m��JG��1&Gkc@����13�1�4�|�q,!v1ɱ�L���4	��>1�}j'��9���c��O���u��B�|����r��k�~� �M�6Ac�a��6%-��Nq�`9\��R�ĩ҈³�<'��(��-4�)������Z?ʳ�I�;m�⅞�?�~f��k�e�w���p֓�:D����b��c��J�4{|�����:$�\���n�*
�<>q�J�?�kz�q�*��"k�H(h�|���#�a�5	���"2�������G6�Ϻ�vS��H���Xko˕��h�P-������^a0���F��B��>�L�rX,��
2-�v>,����S1�f�v��e_���� �Jm�w3�c��CW��;R�:%��N�q���Sǹ����z���4��U�JL��t+;#[�;X����\7
���dxB"���2��l]y�䴄^��?��q�'/���=�_�$+Z�}��G)_b�-��/���f�à=�DNqD��p#'� �I�JҘ�@�Cq���D}���j���C���n��z��U���L�xx�C[��G�2rQ�F�fi��޷�ɐ%�_Do����E%�D    ��ň/ã��G�'w�E�u��%L�ET���$m>�-'�����"I1���7����'	M@�)q>��
i	�J�H䛐�ԭ�^�h�;��')I�Z��CRN+�NYT�>�Sz39��x/l!��Z�X�z��~z<���Գ��z�����~Q�d�.�lAu��t��Uc`�M3y������C-1���l�|�m�D������8lq~�%��s��Mt�c���%ǋ��t������`-ËA ���$@ =l�II&�����������nDg}�����Dx���j"������5b�@-��,/�Ut؉,�;�%�E!�Ȥ���h!h#-P��O�l�<t�R�}D~�#[^ *x��?�Wub=�<Gf�Ei�z��>����ӇZ��	����!/���Mr[7U��v�#�#}��Eh�Q���1p���kC�����y��<�m��J��]�[@������O{#�����&Gλ�3�%�1d������Fx^j*a��~M(�rǸZ��Gꃤ�G�z#4��
�cO���� ����B&˂�7i�T�l�����Ф��Oͪ�ϵt�й�I���[ް8O��!�:tm ��PMt^�,Dx��D���Ê��5�Yݎd��[���$��U^E�5�'���9��w��pf|�óՃ>_�;�����l
����"�T�Bqat�t�p�-6� �Y�Y�`�*�����/>��)Z-���e��d���|��N�4!w�M��c��sv�óQw�%��wق	@Z?�-���c���f��m,�����U0)W���r��CG����C+��?4��}~�<���k9��ɦ���oy���!=$�ԇ���xB�����{.�gR���TR�����b���M�)E�Bj,i�%�����g�/�y1\t',BY�>�k��%�E�>���?7�t�ZՖd fڟ���O!������>���/B�z�>��e�J9h=�������竩���,٤e0.6��,�͋�#t;���if]\�4K�t(�A�=�+J?4�o_7�=o ��-3a;G�����)�1/-`�Ё��{W�������p8��B�=�NH�f��8��y'�^��8�T�r�2�M� �}�5b�R�
�c�{4X��pQ?\$�ʞ�X!uF��p����$� 0�w���@&�T	7=�������/!�=]W�Q��7Q�x~b���
N8ܚ}������ 0�s�7-W
x�<�z�eP��S����[[ Մ�g���$c�Ge�=��Qm��y�m�hZ<)3uQ�Rɟj��P��E��_Y��V�I^���ob:�Yh�Q��;l.5F������B���4�#�B�()�\V�y��<��� �F([��XsH�n�j�'|��h�c��c/C�n&d��vT�+�T�sM�#R{��I�E�E���	�n7'6q��%(�����3z�����3����F7���.���/������E�Z�	+��4�N�Y7�.����jtw�%e��f���$�Tom�O��&���&�.�qfj����4C���nϾ�M��	�>��yA`�Ȼ��UZ;�����hXҾ�tܕ�P�F�.m��҅m�����r�FT�&K5�%F�����oǣp�������F c��20�(�[�cp)Gt�-a�t��n��ţ@�?{d�1�v(K�/̈́iE�
��$%���-� |o}�λR)irk0�� 𫚍R&ޛPY|�X��ݞ�`�x���l��yn�,"8]Z�M���Q ���F{1i//F��x���U�Y)�����̖�GW����=�ħ�n���v ��˃g����������k~暃��j N}B��)1c%���b�|V���e�=ω����Ⱦ��Pj��/�L�.:��5�sI�ʔ3L��3gS��MG?�HϾ��#0��6�m�^�U�(~�)b�h��{� Z�i��$j���9`�Sbk���ν��/�V�dԭ�����jwHE4�����Ἰ�����I��g��N<jFl/��<��_��(���K�S��Ia��O��`�kpG�AA��wYe~�d��UB�U��a?��� �4�ͽu6Ēs�VK�,k&gz/�'Uu{!��W���'���D��ef�#��!<['�T�̓8ha��͋��;>����1(�"4a�?��&���P ����&�ŋ�R�W�"Kn!w����M��Q.��@{����+&�"���O%�o)��!O�w�AȰ�}4˴1ݯ܃�<��ƕ�Le�-�H�,AW��7��:y?����RGC��U�5��>��q�ʿp`�)a(��+��65��.�F�ß�(���]�z�B������� �����,�/'|&DJ��\�,K��f6�Iъ�>wԱ���T)�v�;�d2���Ѓ���YJ�ye��@�㍩����iV{��A�F��/���K�#�����t�~�����L�3$��;|�&#��ʽ���n��w�/��ۜd��
�j��%��Ra�V�3e4��B3��ޚ�f�-���;n`U��>A��x���&I�9��*��V�����))�cu����-�P��j�܍�k_��_�_�&�����G�B�ȇQ���iW���d|Ai	�1)�^2��Q�����]��F$�qu�����0BEQjs���Z�t����[2L�Yz�f�V4��wȁE��_x�p`�S�r�lq��E��n�vh��1}�#�~JiúE׬!I�]tl ^��o��:p��T�T~�hV�K5�ڭZ��#���QmV1m�a�@xʢaQ�k��yӊv�xd��
"�������<d�f���eط��8��ϭ*3��7���/e,{4-c�`1�����h��Ebw\ �V����p�T�3_���j%xe!�'1�1K�D�z<^��m4�x+�9��%=�}��������P�iK�{��ؼ�.@�ΊL�+"'h@\N��I�N�s���#zI��&=D��^&�)C�1���%�sq����A��<��fz��L]������&\���Ԫ��0}��#����O���o����ރ�ll�ڠ4�q�Ѥ��k�ⅈ-G��J�>������5�l�ٕ�<du�[KR�T�};�#\[����F_H�T^v)�ں�*~�vgw��
�9%B�y�|?
M��P�E.y<ոԅ�/��:��9\�)�˟�;�F9'�z,��^�)U3�{�UHtP��⸭��<�|���x��=a��D��H� �o��9�7	�]��(�����z�~+a�w��� �c�D� ���k�<dY���TaÈ���8���9,����^M�e˥��LfH��@7},4"<<s����.8'-�τ���K���d��\t��4�腎 �b�9�O�T�xO�T��^��n��t&��z�&2��ԫ,��Q��t��#hޮ���� �<vMY���{[䦼�����.��ni�<�E�����k�ތ.m���Ft��7U!ҥ�h[��_XU���� �˱z�~͊s�J�AQ|�.ΞzX�*mRv�� }�Q!�F��m���+`B�����gW�=� �눯��97HhPq�P˯����;O��fU�m��g	Z��������!��ښ��܇	i�l���ߙ~59����o�q��Cτ'Jτ�t�y���X�4�0�s�[���E��5�8�����7h]C�x�a%�x�>�\���gW���{#}�A������(�<Q��M�&��ǋ��H)�aj�#������j�BpF	�K�8��@�q�Fq{��R�l�ٚ�v�~Ry�S�n��L���q�{QUSWµy��G�� Y݈��5����CfS�l�ѝ�b�I��=�XJ8D��=�^؞T���ʐ��'���$Kv����,���p�S�-��炡eN�ʂ��a��V�����G�rE70b�O�������L��%7�����I�3HZv�{P�hX�    U�g�����*�n�Zbqb&�-��k3tB�KC�F�"�h\x�w��\2	�'ʣDpNi�V�~
<�.}�M�f�9#˼�0�H����T}�g	��N����w`���?te��^q��=��i�Yܘ��x�<I��	Ɓ:P?D8e�v���Ȯ�&�$�e���Π"��h���4�3>V4��zk~�bWҙf.-��[`e/U�N!<T_�m9��lB�:h����6�(�1�7<w�^��IM�(k���"N�w�&l����b�0B����]=S�����r�2&���<J]�� ����A�\%���S�ń���T�W�jO�8D���K�{�woڙr��/-e�o�Rh����=9���l�������N;>Qq�{&Z�qc)E�A|n$9S�@�����D�u�5S�?&v�]��."��D�}]W�5���ރC�@�6��<u�����v��h�v�P�Q]R�~���g&�G��XF�%�vR_�E��c����5p�M�:�W �X�~{�������Q��L
2�G�g�6��U}C��cN^�mH�C4S�;b�7+�5yhB� 0f�1�hvf	���kV۶*�Ud��v��{-0���B�_qА����郯�X��7�*�k?
�$f�pF):L�=Q��.&�!��"����L4�"�V���)nܡ~�u"��Pqbwr���&kP񢑦�{��AѸ��[�<=���мP%j.�%@J���o���r,z,A��UnT�*��FR�_���I��5�L�=� Ep��:�]S+;�I��$6���#����˕�+�W+c#�
�(�L��5�y��"������7�pt_�"A�'t��캺���ue�c�i�d���MY�I4�O5LaQ����]NA!�X���H�?�~�o��r� ���9�8��j>ӗ��+Y>`S�[�@�fd�[�"����#mm�`7�`�y��4<�Q9/H>2��#�?�o)��M�2�:��h�v��m	h���A�l
_���J�RT����օ����
2;Ф���w~�*�*A���G����F�4GB���a�@�5�-Ҋs�*����桳ix4�U)� s�g��Ac����m\v��P ��a�OɹZH�[�)�49��Z��Rn4�@�/�rv���pvHB%f
�$��J��c+i�4�vұ�{l�hn�	��Zn]�&��Xâ�6����i��y�(ڀjif������"�eI2����㐦�Fs �8�Fz� �g��$ҽ
E�7����S.���8�(���6��CeO���?<���boWȇ�N�Ϲ1��a�wt��{�y���VV�fkM
iB�sË���`�I�ؒ(Ѵ���<KVɱR�Tfs	����V%ϒ�޲�7��ĩ�R)��=�2���j�4�D+�"���n����X�Eޤ�%*F��")oָ��L����}�>�~N�W�!�8o�r'��\���C��T�{���nݽ��I�����a������Wh��'Trz�Eێ4�!:ifC�l�tX�J�%e��#F��碦3��pR��˅�@k�i�)J#��d �p��%��\��v��_��5�xq�ϑ�0z�MB�ޜ%o�#i��n4�&C%EE� �1O@p�Cwь���
�A���P ����WWz 4y��Z��|tS��j�R���D�����o����6W��6qJK >�:�+B+W��V���}���ol�߅-D6�CnG7U��mz����w��\=l�{?Q'\l}�M���J`��fRo��ǯ�H�2o��.
肆!^��;Ǻ��j`I�y�9��֠�,��82��4L)�/�&(�PR�t�ZM���:"Z[rW���I;�ZU�N���e��kUչ�G�,�����P35t�̜�\m1�%@,d�\����r*&#�uv�p/��t��C.K!I�Z��iC#���QO���'an�����hO�u�[Jښo�,�m�QQN�-hX���}Uo���V�Y��0��z�~�:��W��'7z��N���'��!,����XBh�M6F@�����2/�����f��ZO��o�����K����7�VqYrp�Κ=����T��WT�b�W4�I�����?7��.��~`A`�*��g��$������{Cy�K��I�UD%��>Q'?�Y�We�N��A�ݖT�,A�������r��Z�c��!ٓ�[< ��G�l͞ygߏ�Rq����
tL[x����Y@;G�D�. ��
J
b'+�� :3򈋼h$��/�C-��9{0��AB_R�'=zy��FO���;���&�B[�5�BF*��/_f�7�/���ZM��N��ߐ �\ zWn�w��V~��l��@4�Y�����C{���{�+4z�<��KX����+�)�^�s�5�?�^�H�w��3m"R~CC��s�e��0qgѢ�`W7\u�V����R����A����G��t�̉f4�#�8�%�xI&�EB؁rk��+�n�U<�-��d�� ��8:���aER8Eq@��Oy��f�/@�����������V��<4����3��zߥ��QAq�5�ܐ�g!�	}a���H�p��冕`c��z�j��,٠��G�H�Z�HޢQb.
��L�>i�����.���t�b�8oC蒵dB�A[:����j��b7,K݄v���.�k��9�K��ZU�4V���Q��,�*WNZ׌GӶ���Z�;�X�Г��mo-6�]�m�&T�W�|����+��r�ⳗ�q!�m�S� H�6��s�������_�̼g�F{�2p��U�<r�m����jy��/L�Jp�z-�aAф�ag#B�;}aG��;��f��L c�&��A>D�7S6HГ8;g481��3�s}�J���!Qx������-�7� =�Ęo�X�0��4���ٱ����v�ƈd��Wk�;|�%�4��]�x�5F�!>W�F��З���m�� �잃|�m��%��P�|��	I��$?_`�a)<݆<�ׅq�r�D`q��VkQI}^�C6�6�Zp����μř��9��,��Ə3�*��A�F:xF�su{2��`��{x.
f#=���� T�y���f?�M���rt3����V��o;$φ�j���P�ux��\���`?�:	68�&�GyJn�i�8y�������������"�K�ps/�-���d�C=]dE,[��rxzv�W�!��$M�ct��9ɁK�EV��� �0�����m5�Là`�	k���k�aF��7��rP֞�>��x��8��VGo"hD��~����38���G��K8t�=�܀'����V<� qWȹ���M@}�o�O�_Qp|gk<�$�%h�`�*M'��TKIݖ�{�-�\�T�C5"*�~���V��&�fi����K��V���`������� �.���ρ���ͻ������n. r�!��9��!�\A���ؖ 9�tex+�3/�����J�ôAmo �	kU��
�:����/\x�!�s�_��jh߽��ԏcMݡu�E6W�8�J� =D{�QN�w՗�E��C�*x[�5�����[J}|�˴9�A���z�,$�h<��=U��U�2^���Z���Id�o��%�9v�b���̚i�˃];����f﵋�u
n�<�%:t�Z����j�à�W��s�-��Ԑv#6T��mX04̗�O�����%��1������6���/�)�[��LɻXs3�:�Y�Zr?���#�w�Jc��jTR��k�	�Y{��c�ɘ���
��M��o�1�b�ңU�"�E1v���%p���Y�΢{�b^A�����|�՗��'2P�.�@��8l3Bͻd`�Yq����1j��d�>�iJ[ ����V�L�mz����@��'��d��7���Z��ntVS�ftQS9��J_�D��,��EK��dB��4�WǫFPKn=�u��O�^��,⤸zg�p�ὡ��f�#�dk���5��7_z���nL���Hµ(��Dg�i��&����'�     ��?`�OS��!����3Xc|��s�h�.�	�TV�[s�&��p�
䒟�x���<��݆zS�,;?8����c<��A�['QE�se�+�����74S�T#�=����|��#R4{��'��ڄw��s���X�4���� _�n�Oۡc�-D"@�p�t������^ˏF�d��I�A$s��h+p�̯��坣ª2�zL�W)B��g��b5v�fK��D����T�vK�&>�o���C|�U��}��!^LSCQׁKz�7����{��_7��)q�5ƺ8��u1.%@�+��:�C<ܹtk���Ʉ�y�0�L��ΔǸm;�� �^�?nM���Z���cY�X�z�uĴ��7s��%�\6"!:���N g%���f�"fv����'��3���3ڿ�M�.ɺ�����2�_�#
�֭Zx�]���@l����>���`�K�q��{e�e��e�N��=(����8=����<ԀM/����=�_��%SЖ��o��nC R��+[;29��6�0�<.�:�뱲�esDR�Dzo�"g���j��.}DY�{���A��`�{�������"ri��_=h�m^��p������/�x��������L�
VN��s��9�n��D�4��L3g��-nȤ@��s͠�Ml%13��8�Y4cz�5���q귪]�.����5�6��Dms����>'�Z<�ڼ7�l��=J3�a潖��6D��pe��C�-=�HN!�i����3��[N������w�^����M��6��7�r�.݌XU6�}��Z+G�o�E&��^�p奌�#�͛߻�1���Rc��9>�W>^����p��K)B�0�����̈́�7������KF���C����kS�H��VH�݇O(l�z�S �q��/��ೂ�%N�4��G��;�+�����"�?�:5!�ys~�¡����K7���ۈ��xZɷ����/|6�Y�V��R�w���(#�r�����[~s 6Q��%��G�R�����`�L~j�+��\%��O�}�1�&������ψ�ؾ!�獷��Y�V�V��i�G� �Fm�[���&�E��I�քuI�oփu`k��$#|)q�0o�ǰ��3 �ɘO��L'9�G�yqn��3'��ߢ壡O�c���ľ�n��(�⎥�E ��k�(�Q�e�)�͍�3���n�_���YF����Tk��M�d����ꭳm��\�6����T��8}�#F:O*&"ONIm��m�)��EH1o��NPRl�CV�q�mp&����eV�W�$�u�nć�<�xl�F΍�V�~���t�k�إ�ϜF_-Y��@���~�:5�g#�(�v�#����a�y�v�<O���m��:���q`E�vL�k����il��$	���S#'��uV9��SM4û�Y�^�9��pxEU(������r���"{�ǒL�w�0]ή*�B���rK����YO4h�x� ���f��$��-G(Z�}k��l�=j_�͘���`�OY..��C��`"�)���͙1$�Je�w�AA��bOD������,?�KW�B���ꆮ/�?ZࢫDJ�n=w;�%�x[��w�}Q@�H+���-�Ѥ��
�=���جMm%1�7�D��azC��7�YGvb�E&'�49��^ӄ�4!X>��7!s��K���8c�>��BKq]�&7�cD��w�s`͸Ρ�$Y��7z|��lȚ�T93K	k�r�5�����u����̤EN�M�j�^P؆�BoeŞ�'.;���z�"Q�FfF�\��y�->���4wf�Q���������{��3N�Y�n7ރ17|3�s{4���^2׭��-P���m)��C�j�:�YZ1���R��S<��,jކo$�-�g�ת��ޞ:[*5��Q�7������ �e'O�z�zAM�%g�����]�-W-
W�͸r6������:rJ<�&Ssy��Pv��!~�W��G��^�8���KC��/���w�RE��>N4z@�����8���/c�,������-{jKn�Lٻ�)��~`�� ^C�����S�5}@�|��4�����id�1�M��5-�ѝ�`X'��HJ�cN�I�@l��?
T���|�ZJAo����!�.�O���@��Ez�R0G���>�v�3uI��G`���S����f�E'P�C�Um���Օ��=���{eS��o"�V�WP���D$;ʟM]�+��;~�B��z���ؠ2E8�;�qgj���ͻ��IT"�0�V��T�������y��"7U�~a����
����MV���vl�N�o�W3�u�I�Q�~�f��u7�u5���A��$:B�C ���r��l�d�r�|J6�h>�9�0����Ɠ%�H���s(�����[O���Pz��T^ � �`��K6��&���9w-qi�ϣ�Z�� ������Y�;��ih�����d�{u�皭#x�]�!o�sy	�����Iل��H������+zE#��!��w�Gp���.�g~�n�,�} X�.S���g�2�b�$R㱞y)ڰw���~�aZB�Р��[�W�Q	����|LE����y��o����q�Kh��0Ik��}^����\/��g�"�8�X�,��8D��C��F:���:��3-��{pV�E�#UF�����sq",]&��z�DB�Km>O>��4�I��ֵl��q�&ڿw+4����w��ˏBfz��	ϲ��ga�s�3���I;D��tm�s��Dk�a�le�"��ķ 8�#�mL؀�6U8�/&e��=X�2�p8E�O��d��t�~���;ejt&��&�B�Хk���I�챷���jo�r�7�I����(��$*O�($򒌺��ʏW��WP�t�*��3vY�Ajc�E��TUwv�.��B�"/Ge1��V^�&�!Z�UB]������ƃ賖�L�u��x��E�rڳ�k%~���]C�$0fns;�#"3	�n̒�;!:��N�A����a�chϣ�Ä��(Oj؋��"���Y$�X4������Hވ�V� NC�\��&�%e|� 3ň�|]�%9
��k>I��AS[K�f��u��� �u�}B/<d���"Y�9�"K�ăsr}�7��y_����6�rBT�\���q�H��i<��h�M��B)����cR���Vd�Gb� �`�걺7hծ�� �fz�T�OC˄���xW�2�k+��޼lk&>�����4�G��Otj"�۴�O,�G��SȞ�����o�Ttc&	��zBK��:=���\Ϊ�ăn;���{����ݹ���'�-���_ÉM}u�Mm�I�.�t����i�W������bW���q)G�@K���Uz��]��x��Ko�1h'x���Q��\���0��Y��T�{\m�ľ�>�p�n/��~y�%/�˃�Ա�|�΀�D�8��~�YN�ת�J4z���.PZ��h8����?zd�bf���v�$.���ݏe^w�y�hB���
KI%��������W�7�]��#�H8�<'�I��� �:7m��ziRg!�R�W��5^<�k������=�S�`dy��&cqmB�rC�7�w&L7�8�D]P��ڟ�n�QFF�2	z,����Ox�R�G����i��y*��I2��x��07�$O�jX��@nm�`���K�{�})��Y��C�gv��v��dk��J��}�+dX��
���pUS�ʿC���:dCȉ�X��=M�p^z�j;�S^��H˾�����A�����yc+i��V� ��%�������2#:y�Uү3�v���1��5�^x�F�}���6~H���}l�?r���C�r�'���"�p;�U�V������e���<
��4hQʦ���S�j1���󍴽��:����&��&�O���s~D�Ս���V���Ѐ�B�)j߈��8��B�U-��3�l�2~�#��9��"m�zN��"t";�g�4��N�0�    �E�K��r����b ��u��`9b��/Np*����u�@q� q$�������k�!�8�=�C�e��8�5�����%ɾ�EOy
D��#5ԯ�7�Q�e�9DeP��:aA+���b�T�{�E��BH�7���䔡��_`��'�ܹ=�.V~�šE(���c|��,��S�V�` M��ܥ��ѳ0M�;�2<Ir��V,�x&4���°�`uKɬh�L��o��U�p�Zo#⹖sy���dw'���pf*w�q�h��ҁG���<�P�t�C/ס=���7�K?��A�{�����+k"4#c) \˳{IX�+�<Y��U�2Ѥ�܎ ���{\&>¨��: iS��{HF;I��ܳ'�n ���y�0"�������^T0���]�k�8�8��X�_i,:�QHF�q������}�c������[�L/�&���uj�#~B��Y��|���z�-D�S6C�l�~����<}W�"g�[*Cϛ��- ]Z[��y�����J����r h%Pqc�d��[�� I�n�,�H.�/m@S��4r8���|@��[L�H?:T;�T������c�*�1)��R&+\��^�n+��R��ϯ�c�_�?Ѥ���p�-�w��n���k=W:xw�tp
ɤ���"�i<���%Tb�W21��s��&�G�	�Z�I�:�\�'q�̏���!+$�)����{J�>�x"����hҠ���m�ňDų:_RA���D@����j)�,����ʾ&�Y���@.�B��J!�g4md���,nS��E</�+���*y�pW(��Β��_l�A؄~�f0���}zo��^zh���{:���7tefgU�U'�n��a�yJ��H;*-�G��bѤ���@i�Xn4����O�m;a����m4�j��nbEo�hG��p�%�$���Q_�d��Jp��[z��;��}�<�Ѽ�J�"���moL�G���O)����&��g*�3{h`���I*�f��e�}�	_)�B�1��u`�x�$H-��������_�\�{%�U��,�f�"��u�38x�M=�;[���6�~��dj��C����΢�ܜ=��PN3�݃�T��*�Q��!��d�6���i��<h��-*��D�d���sT�}΋ `�l�{'��ݛ�遍�; �]N��R��{�7�7�W�h�?�b̛:O�����s��Sˌ�ѱnz�d�;l����b��:ZOEN������/��e�6���̾��o@y�|�~���9$`qn����ALI��;H t4��N�יP[��ׄ'��T��C&1r�|��)o��L�GI�����Ҁ�/u�N{{��n.x:����n��~�s�R��p�/��:!h��X\�4Ճ_����z�,?م�v�jt�[�W7�i>�6��OM��{��q�g��7hX>��wg�=Ҋ�7�
���@CNh���*=X*��Ri�YEfA3h�=��в��� �3	沱(�#���ʙѶi��8�X-�,Ь���
��3I|<Q��K�#\g�~�܋��f�T��7��J�A{�u��4��Z9��	�yK����.��{��&����'���{-��L_���y�ͅL=��+GFy��G��3��T,��V�A�A|��t�S k�V�_tg8�}�:L3��94����m���%�Vb��,�N���UŜ><�Fx�al�=~�R�PG�H��=���9YMxrs�u3?/F,�g{;]��e�l�	�N�&��3sI�v����Pz��i�},i����+�N���X銦\�s�:a@������l��>� ���Ϣ)��}��e�������u�m8�/�l�#*s<���H:NCw��2$ܑ�o�Ъ5�z�=��,��Hj�S��V�	��+�q.�����a�_�E>�A�Q|}]����z�Z�5��H�)�;sT��/�a�%�e��hv+��5�'�|�z�64m޵�K��$C�'�<�D*�rѬ�J>�>"�E��vG�d!��D�gsm��Lv���z���-�X{�Zxy^�����<��\y��,��oz߫]xK�&�Z.'���swn�� |�$7����h_۬G��e�jd�󪻩���A�Wb�5�4K��C0�r������nW�-�����̌k>�K���.D=f�x�/I�L~3�,�}v�V�r��b����lwKS�rb^ט+�"��a�ƌF�Xk^�S����x�5�;�Y���EU�d��3�m��j�t��'��N�a��EUWq�9�SDF��1BOK�9v<�j��`�,[r⎣�H-�![�}=�?yl������W��#Zu�z��w�jW�V�.1�z�)��������S�m]�e!~���o|KlcY��}�/��M#�i�����D&�_�i��O�I�Lx��c����Gg�ğ��w��\�ô�,��o������������i��Ey5!g4�����1'�J]M��]9@r ��/���~���
��ʋ8��L�Ҿ�i����{ҥt�z7؏��o�$T:�����h����J�6��j�X���<�Ʒ}�%_�6U}�$S`T%G�u��5�r��$��hي��!�A����y)������R���W~G-8�Z>�?�pI�W.xr���.4�J��j+���7=)T|�� x�z��Z��ގ<�+��S�hR�ϛ�V�3��
l�S�73+�M*�<�1b+�|w�u�C�O}���&r����-d�9����X�R�v���*9kRW�n�q����G�ģ�/�0�C~a�����/�oD��S�0$�]� 8�5��0�6w�p��˫� ]�]��|�k��ޛ�5�w��D�V�|�v����G�[����[ےSS��v		3�lSw�����$���Isk�m&��lSF��7e�S�	x�J&T��|";~Y+3��uV}�y�:!��i
?�1�}1�+)0�a�z����3�s��t��Պ�ވn6�%4!d�dq���P����ꈝP̕����_�X��e?����Gz�Hi!�$^ch���['��y�I���ĝ-D��nHO���*"K�d���K;8���ח�<��k��g�̿�_��x��0V)��.O� ��d�8YF'|>`��p����!�2��Nr\��l� :0����g��>��FcIХ�"lMA���UM��;�*���֞ɀx�ۈ"��	q+ ����n�������^��"���&�O��Y�w����3rBB�kf���.���j2��ejz,���Jfo3[�� z�s"�M�/ o�����B[?�Ƀ�H����~�� ��9�H鯢�k����]ׂ��no����'�_h�~?U����\���%��	0,91��]�߿1wO����R0݌,Ś�%�JK��F�<��;J�faM������`�C���e��y�S��@q_8BԮuQ?��=�v��S͚�L����j���P!+>2��n��(Bh�Cy�:����ބ4bzǚ�@��rd*����'�?����އ;�xX}<Ļ��=���ǯG�e�6Յ�È����48��{��.�3u]��u����w�h�<�F��R�r	ӑ��d Ck7�^$�ع�o�̂	�j���d��d�p��Q��=��ᕊK>����[������%�����;ܰzG���홒��]�N�����sM�����~��揭���{��)KN��R��:g�alXtH}㴡���^R�t65�$#����wh7�2����L��?��&�B:��[�$�|�1������E^]�vi y�W�Ak�c/�����2����-�]��֒��#Cx+sO�OJ��mO������\N>��	�jHᕍ!� �5(ɵ��vB1=�j$�$��=�V��Y�K`+S�5�����vs�$D�5���i�;&��sͼ��t�Uc�,���h]��Q��E>"kv��)yh0 �\��6#��</5��!��P��j?�Bx�`7�	�S�x��r_W����    ʬ,�kH�H���as�!�O��d��[�{?��-��G#��E�ǋe0��nʓC��}��"Z�/.ꖪA��}g�2�H+ߝ�Ջ�3+Y��<#kQI4����"��-.Db����hSZ�"�p�uMU��(�g��O=���#�V�ٿ��R�`%�:!M��8�~������<4j+囟�F�z�ͪ�
����6EwQ^LPw�\|ʹ:�##t����vI9�^�y�ـ�pAy��y�h���1J�g���h*J4�8wf����i�1ѹ?����̠eq��8���.�}�}MW5��M��`n�LE��t�Ĉ��"O|���I)׎�d?�9�7���c-�Z�����E�Ne��?L���]u&-w�R����c�x����X��UkC���`�����O��X��4��5�M
s�>[����r�<�xcX�Dx���@58����g�E�88��C��E��3���[o��X[�	�������	����ӣ~e�Q�(벿��#>Q��=�wr{���	f�Xm�m���~��:���̏��GtMRTp�Jx8���M�Yq~kZ�����[����+3�b���Ev�LGׯ,������Ϭt�`2ʖrk�ӵM�)�%5�i�G��b	&�+4d��S�=���:����y{N�X����v�o�3�iy��q�+�� �q-s3Vz9o�����1	�E􌖂�-���9�'�/(e`gރÏ*��x8�<x�m�}6I�I>{��x�%d�n�*��� �^gR�	�F�԰�eDݤ%q���iw����M�<���S����P�T��޿�����EA4�|f ��v/i���q_Yl�M�]�~���;ׯBB��I N7?�f� STe�A�,�������\�\�]�.Q���W�M���9&�hz1 �Xu}������Y5#��,mzcji id�On��NDն�7����n�I�	7MP�F>d#3H/�>�k.�]��(���'�:�+&U���m��R9�K(�g�4E�J��,�8���;�������2+9�{jX�SX�(������?���c��O.�F�j[�LC�q�)���b/C~? �r5���
�+��ߜf��V�D%��-�U�2��~�"�`#��������{�Z`�b�������d��a����K��EwO�ϡj�_T��X�s ��\��%�	��J��d��\��}���V�Pyn��Y���5�uy�:�kW)�=[�1���~�tg����ފC�O�T$��smug �����%ΏScs �x�)Ɉ'�$xӝ���{xK��pW�C-Zd/�В�5\|�K�rz4��ʎ*�$��77���A U���8FɄ���1{�M�Ǖ��~^��P�������w�����$�����	q��'�A(*`������+0˱9^���JwחI���mX[��"���;�����(M�ˁ-nD_>--�+�y���'5Xn��V�UDՃW�)��p�����_S^�[h�D��?[��<�.� ڶ��<�y�w�������z�����#BN��"�d���#r,Dh��k#H��|�/`�{��F,J!�]��������Jy$�g	���*KC~�׸�N��{����J�H
�m#d�}��&8�螵��J�vm
BƜ��'���P�:|&:6�^Ɍ���O���'ñ���]R�ɡ�e������{�#�� ������Ti���xk��y��2��0��y��r�j
BW�nl6no3M�����EN옓����a�hEa�.����,�u`������u�'1�,ɩ��[%c���]�`* ��$�O��	�m�5���Q����<zD�؞��A��+��р���|� �|B���vs����/�]Oj�=�4�^?�d�d$ʕ�@�,Y�Xj��,[�]���c������]|�� dyY>��9�2��n}�$K�P�X$��5�2a��;��l�ei��Q��F<l2�$�|e�Ea/"�$u�}�@�n�0/z3l�6@.@/�]d=C7U7'_��晝&S��R2r���q�8ad��
d@�,�{_����w�n�Μ�$���U�tk p�Eq�L`aY=�$��� ���(�"��Ԉ�:�6)�W"4�ʯ�v Nz��)���2���8���w��|���g'N�r@͂���hm��Z[�ZǮ�N�/���q'ݡ(��7e�L���M�H-�\.�`9���f���~4����U�t�<�\�v��
�Y	��g3j���xd���ҩv��F$N�;v�n@�fN�|,I�����#��3v���;7�O�|�}˶�`�`Q���?�x����b�����nO�&�7�J��vƖ�T�'ED����~��t�4�޻'�I�>XA�e\�K�4SqWO�8�%>�`X+%T�,/z����N����G_R�?�z,N�P�1�%~B����u�O(�P����k�f����Z��h&�P3LU�V��3hY��5f�v��;���ǜ(G��~�u���JE���'�7��v���ZN�MTf�f�.�9�i 6C��{'�cy� ����n��feimx�����J	)�3~aՀib�/b|#�ȉz#��jC��w@�
��D|̬�2��})�]��!/����g�y:�����u��;��'�H�ۡw����)G��%m�
Ё�{o���W��o#Vk7�i����h������N�p�в�5�d�E�LW�%i���.Iw������O�ʮsc��\	��%��ډ|�¦���>��Y��tթ����8�{`7��^����5Yl�&��L�8�����!�JM�\�����F���B�����v�Aן��E�����y�;�A�$Ta�V���SmoM�l���w��<2�;Y��ֱ��u�j��Xx��ٜq��P"��"�ue��w H��=_s��^E���/tΗ�7>*�2��.�*6*��#�V<�Q���i4)E��/� Dh%z���2�Z��ʝ��*R�$B�v�h�ǵ���u��K��6W4�aL_:���w;�3�'�jn�L6�G�t��鲶��3'mW�.�hC���\׏�Q�z��w��
l����Mޤ7<���͙��}��Ui��8�{�sܒ�e��5��~�F�a��^�w�翹;}0�'��뻠o�i�bI�Og٘�|o�ݳom|����w'?�mBj:��==�j(���&]t����\%O���M���|��-U�Z6�υ^���.B�(��l	��J���<~$t��fG1&BZ��~'�ӭE�H|d����Jt�]�)�A��w��ݧ�@W�O���yV(;���U2���^�V�2m���<(6~�&b$c���_%Q!h�(�<��;��>�x[��%�4HO�+@������?��i u&c6!��b��5�x�ʹ�
�I�y�%��������H�tCT�T�5��0�k���o�u)v#ֿ��קy(쟾d%�G�VD�D+"i[F��`�2f�J�zi.�S�:�ӫ�Ox��P�/|/����6��;��HΒ�t�L��rY����c��]$��r<�h����E������~�������?�4|)�����O���^�����u�p�t�`�yE&�`�^6�>�5���;��u*O6X%�9�º��le'���{-�A�7� ���h�}�dqi�i�u��:uo��q==]��b��_x��W��>ó���ǖ<F�F�%�Z��� ),~���j��rw�rH��I>G���p����d,ՁEMˍ����14Z��
����Ώj��S�pM����<� ���̸�/�,�ݰ�bZ�y��%���Oئ5:uG������q��f�ߚف�o4�o|n��ьh��u���!���rq9�&J��#���tvx������Ćw�`�˭4�:NT��5�'���8Ԩ��x�ڔ�',��KW�[S*�vv苐\� ��3G�<޾�d��j8��l��z�(��(��o]�3ۚ��ךYT*-O�[LJ ���
��dA�K��    9���
p;���Q�<�W��H;Vu��E�~����1���I,*�r����8r���� \xem���JJ<\3����g�ވ�?�בݎ��t�/� �Le�ô��mHx�a����Q!3�@7LS�],�h���&��{�7�.����y]���k�ƣ@ҹ��V"����� V�����>��cw��Pz�s
y��O�g���ܣ|�%b��.�=�d|2-�Qͫ|wn�Qz�NE�)��ixJ��0�{����n��v����Zt`����?��ܽ3�RGá�A����t��l]�7�2�=�_��"ؽb�����[�B��w�$%�Ҹ�to�t&��J	u&}���|�`�_��މ^������F�3mD�k���[�sэ��o�l����ghxx[
4I������'=�����h2���9���Z�H�����WR�3���v����?�pX�|�h:�P
4~�yu�����������a�v;oks-���d�g������V��0D��#h�g��^���z���`8,X ��!�:��g"�e;�P���}��v���3����e���oO�j<��!
�mF�j��С�mƲ���D��.�Ԏ�?�gO&lG"T,{�5�-�&z�Jk� @|i������4 �U�1G#9�/������^Y�-H������!���y��E�G�,���Cۍ��0 ���t˒��`y#B�t���{�c	f{�<jr;{�G6	�����L�%����x��>~� ��Y����=zlcp���oc�#T��Vo�.˄.%K�� 9>�]��Y�,*��'�++}N4Z��>���#�G.�R�}����⣆��s6��-qSW��v�=r����sG [a����~���q��C�#i�}q�G~F���cd�u�wUk�7Q�k�|��خ�A�2��3�n���$��7w����s��e�Sf�Ƌh\]%�D���#�(�i���ښ+x�{r���EE��,����V��i�K������]q���{���qnT�O����i>����G�bV���F�1ۍ.�#x쩹�/!��%��3�\Z�;����qzB��Z�J�\����׬e,��7�'k%Ë��?�v=��Wv�=��f��o.6��������ѭ$�W׭_�/��y�T�D!-o�v���K�I�z׆=9i��g-Ay����ea4��%�O5�9d�u�j�%4��n�Êak�1|j��98g��,�Q�4��x�t
�}��~��Z>-I��N������\3놭�0��M��z	b�q͝[�߇gH���;�x��^�5h���c��-9����;E?�^3���g�j��5cW������l���,��ޕK�5�f������ߜ��4-������Cs�ĭ��i��3���1@pcC�v��I;�#��ZlY��6��kD�	�-W�MH���p�����֛$��{MV
�p3�!�(��O�+�(ӕ����r��4�v���Z�٢�Q�ŀ�bt��i�u��<�e�	�Y������u[�n}Y�7���s����*�M<8��?�Zޅ���p������dn���I�J�dw��}c�y��5ޗ��l��#c�°��w�ě�L�L*q����N������e�T�$�C�i��%J�9����!����>?���ÿPG߈�5�܈�n��v[{�#�z�:��C֌eb�3p��n����Ơ����1��v�]���AЉu |4�����hpo���jx����'WD[�{�H�CCo�Ӻ\�q�����ѭ��-��<5+a����v�|�_!:.����V۹���]��N�Mi`�ыa��h���1U���{�j�����8���	����-��/�KT��`ʞڰ)L�j� �G�������~��z�)捈�����ݞ7��n��|=fU��^�C��|�k���j�QZ ��2ncI�$��l҉ `'u��鮷��lE�ǖ�`�|0#r��v��1=ti0z��!\}<��R�M%Mh��Uۄ~�o���/��;�N��V4�yx�����W���o}3������B_���-irl��C�50�̘�ks[����?l5ܳg���|�v�jy��u)X��i��#X^�@ :�m��^�a�٤��e�A3��ѱ3.�v!�'e�U"D��4i�G�YOM:Ek��و
,�������&�(��k+v�t�,�"c�(\�%-�2νV��C��5'�,�jY���l�XV�#)���P�a?�7���7���=��74�p@=^�d*c�}f�ON�����I�j9��`ӝ.��/��Iɟ2��4�{��@��Co�����Q!U)M�yU�	��G�������cWw�7&����B��Ѫ6����ۙ�9����\�m�rh+��VDڜ�u���Ǥ%�&5�z~ѢJ&��p�U�4�b!tde�)������ws�����'#�0�@<5<�Gl��3��U�8N#�:�[T��dfJ�x;�/̡A�T���y\J�z�d�NJVo_�ܖ������M�F5G�|�^q�W���T��9)�w��܆#ȉzwx�����"r$� �3~fyGȒ_.4����{�A�u��v��j:��\�%�Rه��6���Y�Q���Й�C_��N�doŝ��pz���D��b�`�#Vb����a����>�H�Y���k��*�:���j�W0i8����9k��ü��7�r�����W���4=L���,�~F��:�	��p�^J�wТ�
���cF4Y�r�ba�{Yc�f����pW����q��(s{AY,�7F�]�nM76t6��OkO��%5]��}��	r��Bk��{ǒ�Fd>����ˏT=0i�~��&2���M�3��sz�"����8d�˄�5��Ct�MCF��4����_�K�0$-���Qib����3|l)��������g�b|ʭI�й���FK�S%��Ȇ�C�+������tNV�=��-B'ΑO��Q���+L��
�Kfir�0���E4aQ��ӭ|��6��.>�*$��Λ\4�Y_�ײf��o5���*-�Ia�ƹc�+�0�=\和B���/'��[�N١����s�3�7��l�5u��fc���Y��zj��	�����)>0���Uv�"�{٤��*�0��1W�y؃�}��s/���6j�[�����Hΰ��ZR�w�S=�����	�x�6 ��-4, t#D��Z#R���*��f�޵{9�OH} ���+��^�}�ݡ%��<�|����ɸ���dR��؇�F��' �>�*��!�-��-D�`u�>t��>����ie./��׿����׷X��Ο����b�6�g�sw	 j�o�?�f �������4���"XXK4
�z�h'e��͢uV�EÂ�r�m�W�9!�}ki�n�t^hw�_AGCN��.��c��1G��!�jUC�~c�R	�y�UJ�;"[}a�lE
����"2�u���HRX#Z��������!Յ����X��M��VE./�}g�_ͭ�� �3�w��Յ�A��n�E�:�=�H�_�7̀v��F��}�[�7#�P�#�YB��Duo���Kt�Eh���Ĕ�6%>#"/Q<�B��0Tu�6��߹��4-�ξZ8^�D�U�w�{u���4��w�&�����=պ��x��{�����AP��3S����ϸ�wd%�U�:`k.B���*��{WI	��f:X��"ºT�V�,�=�F�2zne�S�z�h�(�a�d��RFH,+��xp����I�@?��p?4(rj��I� }. �Q����*>5&m�7_rg�l`;�;x�
*?t;��?���Xk�w:��w��?��9z=�.�"9�U���y���6Z"'�S�\�RiS�,��w��:�O}� M��Z���)�w�;N�=��q��޲���Bӆ��B�GhV��Lt�|"���K9gk2�R�qw{�Q��4��B�5aװ�Б��O����к1��l	EC�c�&ّ~x6�_,�C�	;�w��    �����8��ݡ��jJԎ3���N��x���Vmϵ�P�xDX��&��l
�c3F_��ߘ�W�UaL�l=XӐ�M�QQ����ֲ�8T�l� �o�d�rʢ��Ae�=N���y����K��6*�_ĵ-�������&U�mH�#�,9]��C�����U8q#�qǙ_��bh�Z�y��|(��#��� *D�6s{�b}���3���J:O���,8�T�۪�r��S�� �(I�w�g���q��̌��]�׍m�hcɐ�̿�9�T�me����<"5��y�N�J���e�.��k��[͉�j�#�իW�{$�w3���S#���B�'l_�"�O�A�O%N����0i.#9"����e����qX��X/�'|I��:#!����ar���y�G�s���Ϩ$�A4��m�	N,����hYn/P��sO��0�tb{�Q�(����X���������2��e$7�v�#�eE���?y��(b��K�W���\v�n3�L��,G�h�~L��\�}f��2m��A&�����]f.s�d��_���h�
�ܲ��N|����4���x%�춬`�e#����w�|Jt-�s�H�aC�⺿~�k9ڹ�:�jrd|D
'�7�����O��3�}#sAJ4^CC���϶w�cϽt��ɨ]�-���cN��������`�@��.O��1Pp�y�ȸecW��.�e����Sw��tB��6S�!1B�K���ie|�tP9�����|�����4�1~J�.9����KJ����!�%:��x��&�[� O�>��Jd9�j�z�D��iYp����m*��m Q%G�[�qل�4�7g9oZ��S��v���o;��k��Xo��K��y�u�wY����A1�ˏ ��&�U�4��n�R���b]ZJ�^7�l�[ѿ�@R�Ǹ x"�@�z/�2��vO=�w����(J�o�s�-_S����ʆ6�컀/xF�1%�7	e��*-K�<W����J�gƷ_V֕7�5��{�>�����9���;릇yjIe�~)_%X6Vx��D��yBۋ���v�	k�8����X$�6<V�����߳e����x���d��o�'d82-���PG%|�FI�#�*�:��屚x���J+O��R�'p��1�di��'$ц�<地F;! �^�2�艡���O6�et=�c-�j��4�����w�dm+���؀}+�s�[�q�֪۽V+땪��؁r���ߟ�ȩ�0T��t^.�X��<Gn����t���S�)�b] o��*Z6:n)jb�/��v@��k�g�L;��Ώ��j�u��$�h�}�E��^������'��X�d�H���8�!���c=�d��C���A,
�rEu����1�Z��?����X.T
��4��`�l�W�K��1��jbx���/z�⡟�,��ae�L�ˠ��9����X=3�,�'���m��PI�������Hm��'���o�<�ߔ�_�D΢m��xkR�.G���#P�"@�B�!;n���	�Vqz��3g*�m�XRI'�G�J����<2�A-?�Zӡ�u��O�s{��K��ud�K�!�U���k��"'|@�N%`N'�y�'CI��e�˓�^0�N���J���hpcnZ-ayV��8����9�q�P�k�eo�8M���Jo�^�ҹ�R��J��(Sv�_�03m`W�ҙ�x0��8���ӟX]� hp�$��?���H~v�M$Su����4f�L#V���%����*�j�u��<k�Z=&��eo���a��)=4!t��Yŷ"�ػ:ɲ��,��;�;kxji9ě�k���КXs{�v"~kn�s�R��%5wϲeewķZL_�yݣ������pB���k��?�A����F��:��/1�B������)Pi�?�܈�p/�L����2�Oh���]�$�%�E��V��N;��d�C��O"��͞�h�1Zk��~�����o���v��D�,�L훶ڴ�%y,L�ۋ�9��n��+.Tc�3�:��K�-�,���w�;�H�//���t�LG�X�[��&��}��Gxa��;�����S���β?������k��FW��v�S���w����)�6*z�L��s��W��V�V+p�(S>y��]�'z��HH;uu}˩���ӈ]<� ��~�����r�#�c(��(�L�A��
��W�x�A���H��hQk�ƙO��~ރbK�<��gkΖ�W��������c�)��o_�6����
z��G���
�ϐ6G'3 �Ҭ9�������p�ͩ�<���C�3�Vf�ge�!���_��v�٦{b��%;�G�V��+�"��2��j��+�wMX�%]�7���(��\ƊfYq,6����� �
�w	�)����T���Q�u�T��}ǰ~�r��Ut�Т0>�,�N-Bl)/�XV���(V�<*B��c8n�e&Z��:�i��5sF�ß�A#ya	e1-��t��1I$���KD>U?���o�r��M�z���=���X�����@�8����XshU.g���3��+�A���T��b�z���>ņ�����9�C�(�+�ķ�>�����}�i�g����ơ7c��6r�Ȳ]X�ٱ�\�6-��H��p��k���= ��B��v�խ��#��ݝ>�bo��F���*�hE�����"�8O�@��N���O۳Q������Y���ph��Q�˨��\�������o�Ab(���?����s��l+�����d��="G>|�;�ȅ�Mƞ�˲z��3t���P��#"K��ޱ`�[;F�)�h϶��X��e�]�bռ/�����o��'��G���r�uO�.ON�5G'/���{]KV%[������3��Hk�\���,�t`�PN"^�:�\+�qF��:���}��mD&;����(���v�w��p��vB_?�I)�+6g��*y�P45uR���| �-d���<��;j��p��7�z^+=���f8$N�LZ����|K ��ZF0��(�-�s��b�w�/-�g!�@�A ظ�S���G�NXrs�P��✨S#[�����ɝ�{�[����QP+���i��A������Y��߀�Ws�K#?�,EW�������؈��,�nƶ����*�ۂ�Ϸ�)�ykW�Yw��@G��iG'�#+n�_+0P|�����$����'H�Ͱ�ݠ{v��t�e`�K���Ɣ{��u�g ��T9]��#�R�:�.����]�gi)Ku�↌�3zu��f*���g��zc���� �9r��k<��7�L��|Y�TI�D^�xt�q|�7x ϝ/�����볈,x�q��'���x����x6b�d=pݱT��� ���)����(Io<�%-zL����{���A*k����F����"�l�o#ld���V1�F�b��"V˃�'�x�Eqņ���M놃ݚg)�}��S#�<�G�@��ʹ�ީ��TvŚ�(���p�[� e�T���5w��՟��=��V&��2J�{�z:� M�n'�h}g@�B���-�4�vw����=	g�<���c?�_� �tWg���,.)`��GV�m`�K X�}���}t���e/����^���*�ط�B�?�{B�����K�SNT��lC��\�‌K�5��x�2�hV��Q�O���W(����T����m���J%29�M�C82.J��bp���M��MZ���0p ��#�N�G�%
�(B��+�.|�@�
x�lo�����/���U�LY�@2�Ѥ��%���c?�&����j�'�S�z��C�__ )�v��c�G��mw�K��cn��.�I�k����������� l^�����S��� T��yoNl
;���y����k7��&1�j~= ^�7��C��|˽4s;��pD���,���
.��Q| �k���W�KN�{��J:D��P���hM5[~TK��D)�(G�_
?ZBr A]��(c1�t������������]W ����Cps�g���\�i��D���b\˸����.    |��g�e�	o�d'M6�mV�k3������8��8;���\�<�w+��S�����������:�^J���5C)�ߋdO����E}S��Ї�}�����6�¥mS�:'dݰ��k��挵�|����D��m=r��yd��QD�"�ɑ4\¨���X��5��OQ;X,�0�[�����I@s�%)�����"R��E�>��b.s�H������:+�Fav��Q��|�)
-�:[���4�p�j��I*jj!�35Y�Um`�uy�y�KW�L��SS
���p�)?���=�l0H�����٤� �c
���FI�/�(�+�����3o����F�c� �So�$]A<8�>�m���E���e|�m����gx��X�:��~�f��E3�i!�Y�LO�����G	-�U�#�J+�T�����v�/��`ٶo�d-��� ;��z��P�pj5Y��3�ŝ��,V��C���)��,�W#_�����Æ�m�{,/lL8�6i�l���ĞF-���!�w��Gm��Y [+��P����?��y�ۢ����y+���м�EWlf�����l�IA� ���>*mm �^��_̓C(O�Z�ĒE����ˍpB�e����I��2t�h:��6���QM���U�9��$M7�3����#|~��Ͷ���zNL	�\�w;z��>A�Y����ŭy�֐�ťT�ˣ4���������{�E$u��=�Ɉj)CyƎ��k��ш�7��0���7��܁�9@q.{@O8�J�'���{��j�2?��Q�di�K�=���DI�?�d�c S]o�y|a�xa��b]3������?�7����^&�o��}��g���1qgg�&���
>�D�i�:ʆG�IA&�y56�9�uy��v[�{�j4��Yt���ª����C�<d�8>��&S�A��F�)��s#a�uK�h�fy��!�Jj�B<�{�$ſ#����6�|�yr��TA�N�F��6U-��6��;m�[ 7�X)c4�#MD/�̩lߝ�o�_96���Bf
��Pj��Y���M_@I1�5�2����|��c�s�k�C��`��qTzOY�#s����&�%������T���-��E�k�}�!��'9���FS�{��j��Ti?��%�ɋ��ju�s�A���(�|�t�S4�O�<�*
��W���O��st�;��{��i�^�����7�:����voyg�o+�I^.�����XWi��scZ���+�x�r�������!�;�+�ݨ�&
`=��`YV_�����0 m�btN�f�,"Ulbѯ��hB�OT��_�d����~�k��Fd��K��'zq�����E8�q�M0(��u6(���F%)��h�j�R�?�̕Lؠ�}�*ghU��Q��a�����pϬ���K�i~���ӂ^;IL��y���u�GˉR����J�#٪�B�;uV�E��{?�K �©�k�!�1�(�r�7)u�f����Y���v������[�p���99��8M���MK�Cs�0�(�:�hi,�T��MB�!����H!�M�)
�,�l1R=ٵi^Y�H���Hj�+�ޯ���k^�h�oP�"�+�Ȁ���tk���S�rD����=
�f6��xyJ�<N�m�e�?ڭ�
U���tn�K8������,���#{�-d�0I�I�9N SW,�X�[���Ѿ�� f�ǝEk^���8[m 7�%�N̿����,au��Pj[�^���os�;>&�y�g2���D��D� �3����f��#m+�h���Ġ� (�#|��i��-��7&�Z��&<}4��<-�&2���)>�np�ΌF��U ���2��b��>��~ɦ`���R�ZP�%+���@���)�2u�A�6�~��42�%
����Q�]��#{�g�fbD��c<����,�zx?k��P2�|�$h:e *�ڑ��aeօD�nAvۍ)����=Y��9I/}'�B���(���*B9@����)Q�qWkb]�9MS�v@�^�q-ˬE�kQ�(\E��s�@��`3⠿-��iF�1
6␯�bI����8�.<��	n!թf캶�w�Ϧ)�b.����Ӆ�}#a�֑`U��|?��!W<�Zy�_@WVs������.4����m��G|�,#���Т�~�׳Κg���۟\���+W��o����ۿ�¨��cG��[���wU�Lm��X�����t��b#"����ЀBj��?0է�b��>'� �Q��I%�m�kD=js��i݄�Uj�.s��wu]���W�*�����N�'Y�*�z���r�D
c+����������Ϩ/v/�"H�/�f�P	\f�,�zC��-�u]��s���֥y�sTJK�'m�1xCNvo�ȉ�w�����uh��1$W�0���jkj�&���Q@4����#_�;�����s_�B��m��b����uPv��|�w��I�.S~T�������tg��^?7~�kK=�5�
B<�ȯ:�g�Qب�v�wR����?��4�*���}�dC���Vk*����s˯���@�i8�7�ţ�����S7m�x�Dg���\�#񳽾�^&��5�ekSi7��E�%��R}/NK��C��v���[~O��SB�o*�|q~��ҳkw\�^�����j4P��j�Sds�����M$����,�J�~�x�QC�Y�����o�n�&�c�O\�*O�yB�֕H{��|ů͘[Bv���y��M��CĎ���"b=^F97����	M�%����
�d�!|S�T�Lg�� Z�ŢV��&m}j�m����uo�έ���;�5K <uLD8��7-�$P�tR!g2^<q�YD��_|�����W�JG����l[��>j�Hk��1"�ܝm��-��?>�L�"�>���QO�-�hbJ���(F��<�#��@���MQ���������΄�"���,�X�[�D��-�p�೩��N�5�I^��$^{�9b@d���h4TJ�5���a���������GI�����������o�U�-.� +j^�-��K-���%.�+�N���	�Z�0�|�� �:
�K���Ѭi�w t�~��Fׂ�?��п9�*��Lbb�K���,���$؎�V��Oz�!�C01��2�3��č���/�Vp�oD~q����1�/?GSng#��5��s&��l����}9��/(�d�ۤ1��g�o��������IQ>������,��y�oS��
�FĆ�Pcbl�������N�+�������=ݝ[!�X3)><��E(h�G{˩z��U�8�]��U%���C�A�Kh���[������S�-ӟvF5\�����<�A�<�2Dkdb�D��)L�����J��x��vs���4DE�L"ze����nO��J4ǖ�2_!���2�=��\�)y%ɼ�C#ܧI��Hb���Q��3�z7��R�h8V�O��<����6NR�����Q)�T]����H�X_�a�Z!�C9��{���e�hY�iuU�{]�۝�M�j̧C�P���>�{�����Z$��/�N5����42�>J�q5�����V��P��͡Y��IU����H9��Ȓ�G��:Ӿ|�����G�J
L�A��D�ȄJW�VTB]��IA��r�[A����ZRHט.B��y��H��d:��Sl�\G��C���Ɓ=}�d V�hPq{dķo��]�{S�O��4vw�O#����5W�L/��s(����SӇ��>�Fw$}0�טmņ%cv#��?���00@���}M�S1�ftR�-t�tg��I��Ҝ�Y��F�;߽��f�u�T��X>�^bl<�
��z��0�V�����Ϸ]�Ѵ�`���2�����ރ�ʚ�By��'Tr3"8�O�0�Y�fw����2����V�A3U �u��dA�$��b�����`K9��A �1L,xp9��J��:�0��O�ݷc�ê�Ӭ�����v7�˰�W�]�B�E���������m�ѡa5��Q�E@��)$C�7A}�:G㡯�gP�Fd������    �S�ի\h:�\���6Q7@g�!�d$k-�p��:b��3�.����cD���=wĎ������%M���I��+;���һ��:���#O/Xʓ�:��f��^�5;E���� 6��:�{�DM��vF] B
��`
mI �;������C�I��b��(ʷy�b��:+b�wA^�TՑzk�ڏ|�"Vxvp�"WI�4b�6�F�c��t�ZC�D�����Y��ꇹ{�I�:��8���~�DM�hc}6͍���9x`:b*��bg=R��T��XS2�	�4$�M:�f|��Z�6Ii���{B�6%Au9��e����~4���^N����������Ѣ��$�BC�-pq�˯�bN�E�m��%��$�𙷃U�} ���x�N���1ay��:]:Z�OM�����';Me�G[O�=�z2�ZI���D(ϋ�OMn����|:m�V�h�pm���G����.���5�����W�I�h�M/۝ntmG_lI�6\�^L�F�}���늟�R�N-�Ŗ���,ǃ�~��g�f���>_��c4(ޔgy�%�x>�3W,�>�:�</a��Ow�'Uh��J<�^YmV���Ѫ��TUR³\x_]@&�:��
�'�[z�}���ښ{U�P�^UC�S�z�5�w��G���6�~���ĂQ�*����R��EKͲ ���Q��X��겡=Ԗ����Ж_]��L�}���{ң>���tk�n���֖�f�?2�(۶�,��A0��"���yH��~i�G�$���;���U^q�4glo}�k�c�_�;��_��*�f�n<�Q~���I�:~�Y6� �y���$���{K��~�*����U��V��7p�J30�fϧ�F��D�F�v �^��o��%�������O$1�����~��BC���T���Qd�`�/2J�c�w=�' �����ٙ���h��ވ �y��� �/@k@`0��)~�GA[�|+G����*;����Vx���K�����W@;sn:�ѥۃ�b��i�|�A	I?������n�e4{m�*Gxh�}����O"�FLZ6)A-}E�p�A.�o�*rg�f;��p��7s�~�g��g�����4��ڴ�Ѹ�S���oOq�m�V�$��8;��(Z�K̰[8Oק��>���a���%юSA�b�/�<YZ�7��6�׽�-��dC���"*/�}4,q��,�j1�v��ث����Q�\wwpv�:��gj�tN�i�D�0��ʻ�23ޱŞ�F���Y���i���a��^��7~����"�v_?	�J����$O$��?8;w�ңl�ƺ�/z5�R��y�C��;�+V`%B�?Vg#.{�hL��Q�I��������	��J3�?~kiY��"�E�wh�3��5,9�)�G�!�'L}�:�'��JFhL*�_�Q�n�7�)e�G����U��j�6�Z��
|(�b�MJe^��>��ֻli���7�Z�㓄��	#�։�Z�2ֈ�� ���<�����`ѲE>s�Y�qm&ڇ���o邃΂���IR� ��
� 6�Hb��k����i T���i^Kt���hQ�β;��,����x�h�����Z>!�U���D@���$I��ԗM9	�����.��CuO�)�	�;b���o��*������dwI������#tt�3�:�'ׅ�Ge���,ᢣ ����ff"C�����WȊ�Ƿ�}��>��s�s՘ɮ^OU���K/E~�Y���#H�"�|d��_���j2�3����֔�I;����ۻ�p�Ng��&h8���������sP�1^�
RG�V���8]}-L4�W!y`6��zm�,�ߞ�#��`��5;���_���e���?�[�m?�f+�	�ܣ�����g]��&�=�(�$�Ҹ�Y�����[Z�c��q,����:_�"�R91��/��+EZ�6d���Xbx��B�)7q�։�D��#�(�.���!��^��K'�_8Yѵz����~+�I��tt?��{ڻ����.�ݠ�ǖdа�d��֊�W�����;��g�j%Cb���j�;�O�@��g����U�U���yK����Fx៨ro��-O�YS��u&�������?=���y�ϕ'��'ύ���F�I��x�z.�Ѿ��ҷ;י'�4;��vтD�,)�o�v�B"lb|�H��$>`k�ް���������J̻]1S�������ǲ*�"��i���	?�5�yoƈ��>Z=��Q�G+��.S��T�4>�%�R���YC4^�V}���<l���=Z�#�c�p�r��6bc�@���]<�.�-̦��Òt� �p"/��L��uMǏ��zq�t�H�9�ZK��h^@�H��@;FI>1�tIΡ�8�����������zT�1��d��Xvf~�(^̴
���"��d)"'��j��� $'�:����n��%`��@|�	��Dӽ�<�3IS��n	L��, ����߬)*K2�u�����ÇV	F|���+V�q}�s�� \	�8�~�{V��
��VvBn�KDN�x���!�7��`Dz*�!t"�׫�g��0�,A'�����Ʈ�z��Ľ��Fr�����5i���Ӗ��y&cw�7v����*���>���� /���t�p�������&+��Z��&f���F0
{���ɒ4���o��%��?�
��i'�<5��N}A9|�s�˩�K�]h:����q��]V@�u�L��ΰR��s�8'�������קּ<�#���-R�&�I?\K�	�Y���NWON΢��j���O?���$������Zjc#�#�� ��I?��V<�5�S��t4TY�ͅu���钿#q��K�<�T�VL�y�����S&�YE�qϤ����|��&�2�� ݵ�ι4�p%��C�忳���s;䈑���o|+�%-E`k�'�ֲE��*K"���w����[�r��w���@��ů�d䱫���G	T8BRjD'v��7�Y�(�c!I��Ȏ>? Kk_��AG�RW�&������c���s��F`4��g:���%q$N"�����Z�ȱ���1*�#|����8�
��0-�>�(bG�B���
�
�~��ce�N�+Znp:EtpvM��)�=�?=���5Fr��L4x�~�����o�U:�Ek��yS�,�kV+�'�y4�$��l�k_,��!�E?E�:}n�'���d��J���&���|�}���2�X���>�cД�s!������?M`�OYr���t�)�?��r�?Nͽ]��H
�u�9�{j�|���oO�\�[��Z$K�4k�l�{��?O]�g�r��@@��W��3��tk?�1W���R5��)��#7��LJ�k���2�(Jz	 �Z�&>z4PX���U��~z�:�+����Ad*�hXGC�w�к���k�1i45U�ݥ����8�xЧh=���ud��(�a�sﺿ�+����'��uA��"c�ڝ�b>;�B�B[G���;#�U@�&b�m{�p�2�ު�?q�1]N��o��w�2��o5���5�����O��6���Q����Ȧ3w>�h��D�YZ��YYʭ�h�"�U}�W�)-M�p?򼾼u���x�̿ d=�Ř����{��F{� �J�5�����E g_��tp�I����ᑻ�lT�����b7%^^X����
�+�����W0i�}7�'G:m"����Ѵ��l���<1�,�'���έ_����0�,���`�jxJ�D�Z7e��ޭ%�O�?Y��h)(w#Oz��zs?S\H���Q��SJ�-)�U�N�g�o��~�7�_�6��<���nshj�d��d�=�|�,���7�9���V��e�O}=�-;�L���kjm�-��	�#�I	)�sR�#�}:ٲ��/'Z$�?���yA�q��&�֐M�Ĕ����J7!QN��qTF�Z\W%٣�*�}}��L�O'oJ��-��X���1tz�~x�(�ǥ��)�    ���nS�������do��$�;p˝6����֭�>"���2o�;�1)���*�ݹ��|�+�e�]8��N�EIf#��:����{��呃�������D��GM�&0���ƅV�<��:J���)?��tSk�T:�ˀ��|����OM��R��C:��Xc����3�^$��uK,.��J��OI&mw�1<������yQM͌�bT�|���"�H�)W��@~���f��zfu7<b��ڙ��2Y���,���m5~�]�����p��y��>��VH;߱i8�,��7W�7���" �h
�6a�w���xe��}ѫ�I2��D|IR��l^��C�|�ՀU�vg&��Bg$�jkǪG��.X{�ݝ�,��vGL=�馑]m�p.,uMJ�؏��l��K�e����ν_̮}����W�~�9f�t1d��Σ4I�ϝH2$Ǳ�-��ƗW�b���w�"M(��{w�|�-��<ИÎ���(����x�Q�kcܞ-�����owۮ_-��	?�?E|#a��Q=��*�[!�P]\c�w�"�,N+bL�	�iJ6����Nw�o�\t)��ӏ���含���qi�I�c+	iTu��H�e6��2�e1#���jY\���'�+����>�'S����3�V]&���ρW��(�ze���,;�e��8���'K��g_Ow����W�+b!��ZLc��`r���u ��
S-?a�,h1[ f�WCR�!{ڽs��𸃏>�T��cϦ�{ޤvh֡%yѴ0%3�����@��Oj:Ӓ�m�K�l˃�L33��oz\�#��Y��R#�俬<�����"8w��7�&M�����Q�"/���"�wc���w�ȉ�F���Hg���\�WL39U۝ :�Z�MƪN��4�Q2l�Z '�R��	��&p��ҲF�sE�ZY*}���S�> ,M��4;e6�5����Y���ҕe}��;�����N{I�i������8�sow��ͱ5��&�F�C{Q�~*�[+�7,�^��|WL��ٲ8R/LTL���i����^��;�E
a`�$�� ����8�)�.#�>�3�u-Y�|�5^��G�h�n�p���"@_ZĆЖ�a+�����X5V��h')��#��@���V�p�z�@�P׽�@
�.��>�"4�}g>4^WB�/���ْeӖ�����-y���j���◳����G4�fסּ#��G{�f�����T���D��Ct�#�e���z��Oy��=��S�9O�؁�Xu�{��MO���D��=9�p�l1��0G��FWd`�����]�� T^����b/�xP��<�X�;;��9U��[�#A�Z%��Fvf�P�(��j�M�Hw��t����_�X���ƈrRz��o�(r�k�fފ���|Ѥ�.�%׽�?2��Ⱦ~�}�#��6g�z<P^�o���'�g𑭃���lW�#禒�-�N�u!��8@1١�m��Zè��\��Q���pf,�S�`@�lg�)�_`�&�T&��t�{n��.��v�&�Ƙ��c�H8�w�k��M���)4 ��l��jbO�u�D
��Ƽ;�X�������8\��~���ޒGo���hXt�����U1�徻8(�v!�c�Rű�����cs;ٹB݉������}m1!�4�n!}�Fj��[잻7ߚ��ݲO�-d���y=���*���I�u9rIV���&{&/`#xAO�z����)$��/�RV :���}�h1���}�gD����I����2RhZ	���<��J���j4J�C�B��qQ3�7�9����Z�ְ�Mױ�q�B����aZ�����	e{r�2ӹ"-O��Ьх'9��0��h2�Z�&�\6$��AZkʄ:6g�1��ׅ�9��z���L���E��ƾ��Z���y���� V�=���<�%��P�[�����>��P#F������5����
A���ʒ���+�6}/�f �>͛�6{���Y� �t�-	���>���J�v��*?�#�����i�����,b��{kO{�4�"}�R�ᒆt���^!����T%�a��x��b�Y�<��B��߈ 
�$5�.����1�9��l��ЏV�ETe#������ ���{���{��ԋʱW�����]H��҇�9��,����.{�B*޷2�ۈ���NvG�bBM}i���t� �&�t��@��,�+��t�_�T�ޠi-�I�8�T�H!��q�������Bk(ؾ��L+;��v:�Z�u9T֔�]����lvL��5^nOwT@� ��z�7�{y{���/����)U�(T�����4��h��^��<w�Ъ�ԝe��d���M��)�z�p��CD�Ti�d�̲=G����A�k�$/��3�Xn΢U�죑���<9�u�O������'{ן\e�Nx�>����ʿ�.��d����~�[�C��+u��y�c=�<����ZY��|�����u5��`;��-�v�,�+�Mu1�T(/�^�`^���Km)�<�o,����#��rMH���Bkބcy>8������7�9������*@'C�˻����~w-��MHB�2q��Մ8~��/:��L�4�?�(!�kZ�J�}��A��i��RO�f�L�!���e'�y�ּGr�����n�M8���%�x��BA��m흙��A��h%a�i�#tb�	Ǽ���Ck6��^7���D5���ȱE��*9�BE'H��L�^�(c#�b�j�A91MCft����_��h^�)�ӽD�O�C��M*�[@�#��[N�(�6 Z��+Q��;_W	���[$���z�Rӑ_�bۢf+���hu�_�d�:�q��'��Bm�<z��G���닯f:f��}����e5�~��̟�'bk��inO�!s>`aM�h�� ���Q!�3�,MPI��5Y������c�C�	fd���������Q�9�|{~��E���)����B�6�ӭ?����\����4�����,D�BY
+p;I�[����YP`�E�j\J��Ro�)�*�B�뽒��%7��e˹�ﭚ�3P`GŁݹ��t.ꤱDBE�)�~'�R!�zj�L������лm�gM�?��p�~%bG��-������TQc֢H�SI��h���7��u��Zj�;eE0��3�&˺VE%�w�y~M:��Y_�c�̙'^�:�:EdR=@p�4�i䑝y�Ǡ�)&���a~���0ėZ�/����o�:����r�����3��0��؝��]�v��K�0�v*ro�Dܰ��L>9b0 ke"3�ܳ|��8MI81rn���# �E�A9֨�I�g�[�/s$o:�+U��a��G����C%%QUZ�KseT�˾�p]j��]PS�uW�M5gѢ�j���"��G�Mto�tM�io����?�K�٠"�K��mÞj��n�MS��F�C�ϖ'_���d�5��v�5�R�k��)w݆%9u'M��ʈ}���e�o����3�G��٦�$�	�/��\�_�*)e��kX=���8'҆_���R��2ƛ
�y�k�Z�� �#���HS1xF�-H��!=u�����ϣ����"-�k�P�VJ2�q���A.��=E�@�X�^������Jee�h��5N��q��վ�����q/��#���3uBF�\�:�Κ>_ti�=Pot��p鯔��[��^MS�i�*�*��N��?&�X&���ɅhS'�U�}��l2��/�y/m/�o�����󋝅�eG�uWE\�4=�"n�r��u�Ul�;��y_,�xCpv�[?nZ���Xe�Y�!(]i���U-祜<��L�`�X�]�l��4��]��Gc,dw�h�^�[dKo5�qs��TI��m��-'!'ë�F����:�������H�9���:?�^��'�_��<�[d�:E�#��D3���������!��/�������7�!7��<��F"6h�xb�`�J�������~:��Aw0���    "H.g(e���Twn�Mڭ�K\�W)j����2dZ�y]j�wa�6��`۹�ݑ{�fȉ�/��:X��G��We��<_�RÐrpkͿ���o���u���"��#���L^ǜH�)��;!�/~�HG�o��E���`�$�.�|sɨ�h72E��y����X�
/>�ђA�Z�l��u�(z���T6�=���|�W/,���:���5�۹�>hŴݽ�2V�6u�;6�#� �DȯѦq�{ܔ,���i��B��{!`�ɮ5�h�W<�G�a�b�z�_Z��N�υ�R��f#�qX~ ���#2�~�-Jp�Y�P��M��,�T3����<�ͽ{�-���\"�U������ub��?�Ǫ
�5���h.v�]VN�r���*U5:�[��b�#�;��'�N���k���r����Dɰ(����}0*�glw�R�omo{"�'�����K=l��~6k����^�!����+p��,����c�H���pN�)B�L�"��
>��ҏ�F��%p�Z���Yi�	xX�D��e�'_R��x��T0�,�3��^��䄚�]���GЉ<	F�)U�A���^����T�����WS�˗B��������`���p�'�К��d�4	~_@O9b��ZI����F�z���R�<�&6�2�[B�X�n'ne�JM	+ba�e6Ş�WS��J4�:N��/(]�bAε���L�/��]�ŷ��_�M���J�e :fWr}S�I��T�MT�����1"Js������C��I4��4Lȯ�{����aOn�͕��;{=:?����U��&��vGZ+j�]��D��)���n/Յp���'b���%9@=��w��o�&�O��Q'����^���x����DPI�Oј?��j�N#���Rg0��[-�a��@�]�@�v�a]V�����wo-Rz@��W�MLprk{��~�g� �^�iӚ�������&���i{E�s�#��ZV���t�4�h+��)�f��eŎ+EuS'�L�~��H����um�O>� �G���7�d��tm�4�-z`c� �j����9�K����ߊ��0Kf	Z�YՕ8���{x��r���^S��Zm�fw7"�J�N[�\����,�F���َV��P�d�ҍ:�[�-�xJ.�~@ے㹶g;�4lQ�����0h�|�VV�AGn#��t�Z�z�l������*��.�����Z��f�K�ia��C"4#��z�����eY�G<;�Ư9M]m�2��P���tң��S~#�n�X����E#H��U�*��X����2���J�̺��d�J�; �p�5����AM�Af.��r�çc�U�%U#�[h�\l��j]9<V�ݕ.�����Tmʏ��r� f����Q\ROFp-�a�a�pX��lcf��q/�+���ͮ41y���ͦ�ρ~�I��ѫ�ɚ�l�����*�g�-��P�����ʭk7����,�qm��qMOT��6"�Alt�W�}Ϫ�`xe�$�� �1	V5uIR
r`���\�"�.�_nh�(�5�/2��Y8�9H_iAŧ��k�B�C-{�Ǭ�S �>�oy¹[,0�d[��{�+������^ %7��	}П�=g9��+�r`�D���P����!�~�G~�?�Ԣލ�,}�5U�_,�6FB�rF�M�=o�������y�x�{Sn`1�M�[�ҿ
��(�gF�=���Y^���Ȁ���Z1_3����쥻�ˏ��͘m����qG���m��BV��d��n�)��e����?Xf�̼�l�t�x+5��;Bm�i��k
��"�\@q�yc���Aa���Y��e
w�$ Nͱ�̩{i��P�ߵd<�2{�Mi�>��OL/g��<����/�Ã�I�.�ܔ~��E*{�%���
]v��!����,Ꝅ�f-,�F��2��n�ݝn-��S����d��-���Ln)�bid�g,��`-��f�#hd�Pܦ��|� !���� ~'��D�Z��=�^�X�K�L=��ζ�W�D��U��w�Dۂ�_�&4&g��m�B�~�3^�`YaRe�+��V-�4�պ:��#P�M�R����W	4��?{eg��+X���M����7�It�z�4��wr���L�]��O�%��ȋ�xi��z��3���ڔ�d�!R�o������3Ʉ�X�J����Bɮ?�0Xj.�Η���/���Ҫ��gx� ��g$<%�B{���?�� Sީ�HB����7y��n�oL�,Ñ�Ӧ|���;��,�u"�<�N����	�g#���hr��;2�� _
�5e�)�or_N/�%	�nk��Ļǳ˶���hi�g{I��=y�H��6֙�t����t��F�
��0X�o����i��
F�E���[^�u�׀7���V3�K�E�!O[���x�.��`a�i�L=��|�V&�5mk�� =1=�=a)��&�E�sՑ6��XbjjPwf��zg��0G�R�ڈ�Pz�k,���K�0?� �'�ވ$��?�<G�cN�����Qz݅��R��y�%=1A������ux��4Ǽ��������P�I�iA���>7�4�\?��q�ըX�K~�e�)!Q�o2�T$.��q2�vK����܅�L�km����8��7�̯�JY��Ъz�L'H��}͌�Tq�����y �0����Mu�P�p�34jmDr^E��q�2⍨\�[��̹����n�����0,��ez`�k�>@�Xa�O�c� �-�R�N�E��^��㎏��������Et%��S���&(n�wD���Q{$k	�']A������������U�7�v41�.��)j@����߅y
��[�=��p$� �ˡ��8�?��b�g-�EO[��^i���s��ϱ�&�&ϝ���n	�#��y���n�����2�mt,Tj�s�����L�O��$�X��W_�����0�J����6���?�v�YX�]��½I3?%��w�}1�*Msg�ԿqC�[*YXAO���u��,�-U��j��D�z�ؕl��JIvr��E�qꊖ0�G��{h�Z����2K��������I�Z�琞�K�C���֤���M��W���!�v|id��B�{�[����#~D�)��6&Մ�`��0ٖ�'�n
���l\��۝��`_�<������n�4|��,��0�FJ`�bߢ�@gsM��(Y����X�J�vvB<��&8�L5����s1�ϹshZ7��0�]��ز�c�~<9^Y���QI��Η�I��=���=����lv8�"6N���$�N�r��q���蟰v2�I�_'�K�KF\=��	�W-sF�{�I>��UmLX��B��VZv#�'ij�¹�Ο評��3n���[�l���,��|� ���$�^�љ�as��"�ȧ��}�ϵs�>��2�*@N�~zg�tC%��v�
;�H�ʾ8�MZK E�X����s����o��v۸��3���X�Y��xl�Y�����1�H�a�-rcw�2��H�"	�{d���6b�Mʜ}=kWQ�_Z�X�s��׵os$��A�)�3�'}2��j�A�i�B$�%/ ��I��E��[9�"�v���?��\~�X/`5���{īv���j�Z�v4v$N�o���(�V��)�9I�E騕�f)�=�DW�Hs�)0J:������a�%Má8 �m}1�g@siֺPziC �c�Y7�$!Pp@�O�8�[G�MR%dCclZ]<��_^s9��?��mi�����������iq���qb%V�%G�f���0��K�}�T�x��|�ފ�l�2���J��U/A����/Ы$���3�����,0���e&��i�7hݞ�F�eu)B=��Z����X�!�D�@�̅�E\E�h\7���{����߼�,�P�e�&��Zڷ�ڈ�|R	 ��%�a>���`A���d1UB'Sq��*j��oH;R�W��c1g^�?<�?��Ii��i*���hY�    	�Ri=sz�o�m���Y=��E[\������a�P�;�m&
8	�h{}�� ��u���5ޚ �9�\�r��[/�ۨH��S��/-���Y�=x�Ϥ2��ߛ9;[^�\���?(�%�-(!I�u%�:U�;�5�0v�괯-�	f4�J��`��VJ뼠:�^���%o�.��o�иC���qq�s�68�慀;�`C }�m'�%�X������,�G!�o��-u����!������ϔ���G�D�,Ri�զE����P�N@�.���eܪ1u�m�k�Ժ�@�_,j'l�ğJ�����G�����GP�R�z���Um�r,	U0�����ױ�/��Լ6��,@�4b0�Y�Z����AeCHH����o�h�̘-��9��4��'��a~6�
���5���c�G��Yo�e�<�O�ct�f��/�fZc�4�����c&3%}��g��~�������2�E�\�-*K�R�&���y칁�����Q>��m1X�ࢵ��~�
�ѯk@��3=Q�'�܋2�xJXk�N����ފy��z����`�����;��a�׿�(\RɄ�J�Dq�|P$�����0���=i�&_��6����)nLqm0��+`�Ҝ�5�����$ -qH�Pr�Ȣ�f������*aNƲ�1k���j�I�䉜m��>�$H�S��Dx��L���g��!嵹��I��rd�/;���{
���Q7�cn4?��1����lg溾���;�$�*����v�()
�x43��eI�4���֔�#=��Y|'Ϙ���&��#&@&x��S%�ƜN=680�|���դ
�m`��6]%�$+�4��wl.���#/�p���K³a�"�}��Gu"S:D#ؕ�s���s�S�x�5�'�f-0qNY@��n���U�
Bd���n�ۆ��8'�|1��ܕ� ���9�_{7fI��}�l=mt��Y������䜁 ��vu��=�����\���Y��f�5�X*���r)X{m�'YA*rK}���Ң�eG(WX���F����*�iU�����9�Ly�����`��?#�k����g
���������S����u#���e�?�m*W�fbv���]�K[��%��+t��g��Wƪ<m����(ɪ��E�Z�����>�3Q<����Y?�5$��@��K@�z�F����AhWk`��+`���Ah�����Ne%�R!���'��U2��	O̾�vY'v,�yɃm���k�	��t�	D9�"�bS��l�`�I*E�p���Fb�Z��/}�V9Q�������n����^}�w��E=�Lz�'^�ϻ����S޻9]���yH���0d�WnM2��kI�^x��
IQ�8I%];vb�2>�K���C�HJ'U���q+Ź�k/,`������J��N!��yݬ׊��V� #�-�z�lYs�{+4��Q:<�5�s%S�c��{#���#��n��eA��9d����erEl���ٴ�V�gL�h��	kH.���d{x�50< .��ㄸ�?Rq���C�M�?B�=��Y�������(�Y1�_��7�z&h�=��D�����w��3���ۨ�A9�ߎ�:���K󑒁^1qm�p�v��%	���\�׎�q��]�i��A� ��_�r��&������b��/Z�Ӿ�U�^[�f�&u�~�-`l�"��ɂDveL#O�n��Ɨ�D�WS1+g�k�����
�1Cw��qk�	�C�PH����d�
f��Zl63qR��v>�<��t�<�Ɏ�Y�����|�'I���?��In��i�mF�C�bP��'��훏���U�OZ�cD:!։jE��g5V{�X�]9~��j০i샄r9�($�D�)�5��-�o�����@	�1~)��9���t+z.S�{��t@���$�prתY�RI�rih����Rgt�q
�|Ĝ�ƻ+9��Ыճ�q,X��L�m��*�t/ ��u��$z��X[�ļ�F������K�}zVMցv?ԪI��0���1\�KM2�P
34�<�qb�~	!�tU��^�������M��!6����N'yWm��Ԛ&H��u4~_ր�ζj&���8��;����twQ��J �vo`:F�i�J�N�M�}�L%yw�I#yj�j?�Z��f��[Zt�z �׷�`t�����3-�s�
���L4��O7[u�~��@}���v+h��c�6�o�b��'������ķf�-|�`�T�e�������]i�{mB/d�t/h�#�����|�b�{��|���*�k����٫�^ ��މ�.8����P�k����/�`�1��i���,�*�ro�i���d4;���>Y�o�~ad�Ɍ;���w
�G8M�y����֦|����$��oL=�{�W9Ya:y�,�Y�T�D�m�J��z�X��@m��w�޻Yz�e�g����sG�â@�,2ז%�\?9�VL%�<��E[M�ۓ�Ye�#���ӫݽ�}�=�Ҡ��wNp�H�v_Y�g�5����Ety�3X-��3{�P��@��X�ٞ��F��J�D���n�+)^1,�_�.}�����_W!�V8��b��{p)��B��W�Ų&��|�:a╇e�]�*��vŝe�Jﾧ���Խ�\Vv�7�OB_�+�ǯRx)h3�`���8�z?P�� �&�#Y�뽱�H:��Hݢ�N����7������ ұ��GA�*iX@6X���������<'�[��9i�p�u�ki%p�[T���{������"!������<� ��P�Ħ��g�f�"}�s%�Ӧ�r�ߵ(}���]�0i�}��+Q\gpj�SR��֩x�����aEʹաL��߽Q�|����X��8��*�XG��Q���8�C:�o�.E�ӒG�U�%Mۂ�ո�rkn�+�V��Ζ�ߣ�%ʼIϯʑ����\	�ث��,�EM�Ȍ�?1<v�HfU'��0��ok�zm�F֪���V%�-�x�b�|b	IJv�(a�GΑC��!��L���׳W�!��d95��WE$Qz$#���j@A��e�g ��
G���'���f^d������Ȑ��S�e���;��Z�a_����ܛ̣Y)a���w�g��K��Z���NvG��q�������G*��e�w�4�굼�� �吚؝���08�emB>��0�����u��޾�����j�?�����^D������,�T���?R}F2�e�O�z��(����>�RH�\a[v8��~b>�T��V������c׀/l��F���ҩZ�Tr��D�ʾKw��ɱH�������&Ղ�(J�Д�	��̹b�����#�쩔���G9�¼��#��&~�<��˟"�[k��ZX̾i�=˝�Mu7K�����V;���W8n1Ӝ���Y�-b)_�ޥ:���o�"}mĕzl�Œ|i:��q_͢�T,��{�J��!�6ݳף4E8�im�J�
�?�KѺ ������E ���Z���B��yi'��j�]�a�&"�؊�II[����ݱ��+�F�ª 4�i���Yf�V��3/KS�V�zчW�"��ѿZ�Z���T��'��8х=�F���v�!h���bq����m��y�v�k�q�`\N놂^|�(�Yc�'lGU}���c7©����1�_�ʴNÈ&�m^���ԅ�+����f��*�"R�t]1;\�t]��dr��/�%V-#���w&���fj��n���􊫞�94����>@�p>�A'v��U#���^��&#&���~'�}��b��d�ޚ�Q�3��yp�؆��W��M'g��Y�g((�ә1�ޘ[��3�m�H��/&ڰL����<����Ik�Y~��D�7z��0���ۼ2c6���W
��ԿW�󒗻�ͥE/Y��!�ٹ;����+�H��b2ل.u@��.c�i�y�ł�{��@p j���<d�f���Pm�ofs�)i+�jY� N  _�Y$�L7���.��x����r��ȑ];�]��Nx��N瓇\Yb�wC������e�7��"�����f�d�i$�fV��H�J�e����'��W֤����{ݫ�+���e���v��n�u[j�vM)9�
��V��/�@$�n�yś�e5�֝�R��rBp�9w��=��MM��� g��~����&�[�g��l�����@%�]-��NtT�����⹏����Q)W��vⱭ��y���a\1i��k�A�%��x�j���(Xh��F��f���
�5��	ʗ�G-�N��f�[���?W�g�����c?u�a'^�K�����!�x�ț�#zpc��C�h�^�H�o~���;x}b��*��2����_J���ܻ�XQ�,����^7�u�hn����j�ۺ�Nĕ���������{����H.�;G�;�#�>��}*.�����f�����������w1�G= ����v�J�kFy`�\��mS���#�{�Z�{�l�7 !uC���L��.=q68��[W@s#&�<6]����f?�x�9�c��=V��|�DIgE��A;�YaD�ci:Y������8�� ������5«�ܣDmOm9�@�s\��hS��y~��8Q�h	y.R� �O�ɩ~����c�"=�dJ>��QfR'9� ��	\Ч6���}xi�z�xxiH�1x�Ҙ��.M����1+)��M���x�W[��a)}C@W�&sF�-k�x0k3�|��4���tZmƆ�S��������_��t(��a}�u%L�YE|;XObmׂ�`p��-ه3�+���#�XV��Y��e�Ex��'�)�����{�&��yn>ʐ���;�yR�}j؊��F<w�2�3�],��%?S��=˚9/z ѨfZc-��!��EDu��Kc侴�s;�N��bwoV_X��u8z� �ͽ�.��"��Az�6���2�@O_\�TΣ׸=���t�v>-�ܿqJ��lL���U�����-�j3:���E�<Ot��7X�g��[�(�h�� �ED�鋂���B ui��=&>��E.5���̜l/��x<�m�g��(H�@�8��d��{&g����pO5[jgv����d�L���7}pǙ�:��)����:��/@ф������;��MP􂻻�E:�Y���1N�f�jQB��H�k+vy/�l�[��^�*=NI�5f
IHY�Q:���-��ha��P�@�x���h�6me��}�@ύ�L����3�>�E'��9�|��e��R������{)߬�V���Ob�_F,�;>�M�ޥpY@}Ж-��(�q�Ɏ��,(���	�b�f����r���o�(S�s�N�WU*J�р�i`��|�E�h�eNOZ�ʉ���n1����2 �i�͞H�zL�
ݢ�����x�۱�3���Y��0���,����q�+H�Srd��g�����ۃQ�'l7䟬�O�}8�{*?Y�챜} �'�ñl�7GA.�w9:��-z#�x�wq�m���i{��A�#����֎��yN^�o����>�pezmy����e�]�v?�Z�.�M\�C3�8p�<[�dƠ���'�oI�>�)�2�Shs�m�ZIhof/�E����S��x�ྫྷ.n��rռ&}w��M(5���V�ػ?Z(�z�H�Â�r�\�e�"�|J+��1CE��q�`��=�JΣI��6Le�X�<t.@:i�g5��� ����2dt�s�"��%\�q={m�a}�zܛ�%��[N��Ž~k�"�}��,�a����\>����Qj��\<�G95^��3A��ErY7�5%)~`���(���u
�P^���i��WI+iѲ|˞����l�&㗛i�Fݳ�di����M��ʀ�@ҏƀ������~��%ﶄ1�xh��x���<��ZA �O����޲�����������~��܀*�
�P`)��/m�M�J�Us!���ޏ�(D��spl��*�(	����sy@��=�����"�˪T�5�.�C�� �Ny��z� hIut�&)k��S���8T1���\����l��X��/�2�r(8�u,�E����W����IfzU������8�A�G�y?%>z��&Fp��"�/��`��2�,��|��y j��T�>�kۇ�+�3���)F�%���`�I�e~VV�8h��9�M��U)g:��\g�!�>�|&`�+�"�uIՓ��=1%��/:�{r��\O�$[�I��]�1J9l.6Ⱦ��0�n��l�C� �s��#��87�[qC±wX�U#h(Op��6|��)�+W*����G?�:w��2{��	��O�k��͖[��+y���Ib�h�xb��XE2]�!�n����^�kD�̸VZ�D��6'OGhQ��g`���|1~�CfU+�Xb��O;Ql��;&[��w��� :t�{����bp�E1:O�Q��S�\��GVzL�ej۳Z�څR�8�@m���E�tZ�y$�vP���֜��񄎥�'Е?m,G�W�����ml��ԛ�$������?���^G���`�L���L�2� ٦�Y!�&�Zsţf�۳�b��:m&�m3�x(hlh:���s��?���4�_x��H�D���%��%��.��Ls��Lk7�k��\:9��9���M'v���$l_�tMD����W�K)�h��{n���\ҝ��G!G_k=Q �5�-1�Mw� Gaѱ�<�j��rcᤀFz}�J(���)�LGr-@����!�_�ۗ��[1(���I�y׈ђd2J���B���~ɋ�D{v���S5Į���^x�0�m��d6�)�g��=h咘+�0�]q���V�/�a7J�ܾ֫䏻%i[	�̎-<�6���r��9��E����E�j��ޫ�w�c�tl���@ן����� ���C���f+���˱v��@��%4���J?{Vx��Z���n�w׬ 7h�^<��������}�Kv'e����_x��I�I��bc���W�Ŵ��l�s�.�U%�\���k��|l����_|���1�	      E   (  x����n�@���O�%l(Nz�ˀ�Eb�����|i}Q�C���P�
�QUhU��V��<
�'�H�RQɲ���|���3^�{q���n`o�i�6:�I��^����~3Ua�ܗb(�S~[uL���g�g��=��K��c-Q�8�QDt$���^��G�i݁���~W�X��i�S�j_Eٵ��r�p[�D����%�{���O!X�j"|����Y��L�!H��@������(��4K��:���]��2rb�� t���*�ډ�� �j�����qN��U�z"��*�3A!��9[���*YX�G)<�uꜟ�bWg�Z�g�Ѩ/�
�HZ���~,Sމ��R�,��$��<!~�e	�����,ó8�;W�ρm��@E~j��o��%}F�ɸ�H�b���dhm�n�={Cǡ��~(;��mrӓ���}��G���9~Ӎw����Z��v���x�8� ��D�c�
<pS�)�{��`�V%C��ʏ5�w)k�g�b������8�Xo�ڟw�g"NDp��EX���>��c���-˲~ (p      G   �  x�uSMo�0=S�§�H����[7 ݂�@/�(�s$O)��G�n�$ݑ��{|��n�M�ژ�j��ِ����H&�.����3	���UE�N�P�9+�޻�c�*X��fcPk����nO��x-US��6*3"�,#Q��8*��9|Y-ro���n��0>��io�j�j�9<��.�bm�&a{1�d\��;��{��P[�M?fɸ�7s9'/����W������ŧ��Qeu5OC֔�dP1>�%��7{����ơ���)X�?��R����ڨΘ�����UKk7v[��`&:}&*a�|�o4�ձL�T�ٍ}��:cDD��5�����YkFϤ0�'���W�����Y׺��oFZC�?WH]ךwɩ2��r���=>�Y3)��+}֑9��#���r �s��Q����{W��K�u-6�B:�7H�lP����e����J�^?3��ɺ#`      I   9  x��QMK1=O~�����~^론nO/^b	�h����W�"�QO��zTV����)&SE,���ȼ�7�M����!U��ݤc�b����^(>~���D�#�_oc_�3�W�cؖ�)��l�DZ;҄!�S^���5�'L�X?���dW�k����qН2�ĖF�u8̀�kOO��������؀}](L���d�%6!m%�����B�f!��h�O�-��ao�aƊ#eX�;�Te�\E�3��@��~��O��?ynC;o��x� ��N��~o6� �pm�ri�ny�����hI�	d�2      K   U  x�}�]s�J��'����e3�o��Ub�H�(���͠(�|�����1'�즊*�y�����m���uݼ��V�s"�1:�y�;�ۣ��)���*{��L�x�u�|�jk�o���~k>�E0��*pA0�qΈ��|�aX�y���Je���<���Cᗈ\b�a�EHsh0���BW9"B�?��gx�Ld�7Q���y�{�w�����_C ��Tar���G���l�]2ڌ6�Y���܏�~7q�,�\s���]��wu�9�U�B���B7)=FD�X�3��-$�A������U��'X��B�R/�YZeI��푥ٙ
�FY�����Z��e���w���eִp7���eZ�����U���M���Mٯ�e{չ�w�F!� �b�3��%��''�b-���T�Ϝ'*F�`'��<�c:y��H�eS{�|[�܄J���p�@���X�۪���ת�v������-�k^u�w}}M�k3��t�,����jZ5X� �l� Ip��[>��E��:����6�N��l��CB0l]�k}����{#
|6F~7�ڇ�>V�Rg�Pkc�M�\u콃��/���|"ߺ$��[�	jΣ0�D������?�O*ǧ>���e���*�Ru��m�=i���F�;j��;������@Ņ��:��W�`q�d����	�C7��^a�VE�Kb�����]�v���:X��ҩ.tg���{ؿ��k��4r�4���y��j:5�	��f����(��x�+��qeT=���H#gm��{HB+�T֚��bd�B��y������@W����4(c��#�ŷF��0JD��Qƿ���޻������~*���      M      x������ � �     