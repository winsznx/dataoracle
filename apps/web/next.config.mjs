/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    transpilePackages: ['@dataoracle/shared', '@dataoracle/base-adapter', '@dataoracle/stacks-adapter'],
};

export default nextConfig;
