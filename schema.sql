-- Run this once in your Supabase project's SQL editor (Supabase dashboard > SQL Editor > New query)

create extension if not exists "pgcrypto";

create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text,
  created_at timestamptz default now()
);

create table if not exists transactions (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid references customers(id) on delete cascade,
  type text not null check (type in ('sale','payment')),
  amount numeric not null check (amount > 0),
  note text,
  created_at timestamptz default now()
);

-- Row level security: open policy so the app's public anon key can read/write.
-- This is fine for a small family app where the URL/key aren't shared publicly,
-- but anyone with the key could read/write the data. Ask if you'd like this
-- locked down further (e.g. with a login step) later.
alter table customers enable row level security;
alter table transactions enable row level security;

create policy "allow all customers" on customers for all using (true) with check (true);
create policy "allow all transactions" on transactions for all using (true) with check (true);
